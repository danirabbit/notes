/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.FolderItem : Object {
    public Camel.Store store { get; construct; }
    public Camel.FolderInfo info { get; construct; }

    public GLib.ListStore message_infos { get; private set; }

    public FolderItem (Camel.Store store, Camel.FolderInfo info) {
        Object (
            store: store,
            info: info
        );
    }

    construct {
        message_infos = new GLib.ListStore (typeof (Camel.MessageInfo));

        init.begin ();
    }

    private async void init () {
        try {
            var folder = yield store.get_folder (info.full_name, NONE, GLib.Priority.DEFAULT, null);

            yield folder.refresh_info (GLib.Priority.DEFAULT, null);

            var uids = folder.get_uids ();
            foreach (unowned var uid in uids) {
                var message_info = folder.get_message_info (uid);
                message_infos.append (message_info);
            }
        } catch (Error e) {
            critical (e.message);
        }
    }

    public async Camel.Folder get_folder (Cancellable? cancellable = null) throws Error {
        return yield store.get_folder (info.full_name, NONE, GLib.Priority.DEFAULT, cancellable);
    }
}
