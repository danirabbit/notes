/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.FolderItem : Object {
    public Camel.Store store { get; construct; }
    public Camel.FolderInfo info { get; construct; }

    public FolderItem (Camel.Store store, Camel.FolderInfo info) {
        Object (
            store: store,
            info: info
        );
    }
}
