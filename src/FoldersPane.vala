/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.FoldersPane : Granite.Bin {
    construct {
        var list_store = new GLib.ListStore (typeof (Notes.FoldersPane.FolderInfo));
        var selection_model = new Gtk.NoSelection (list_store);

        var factory = new Gtk.SignalListItemFactory ();
        factory.setup.connect (setup_func);
        factory.bind.connect (bind_func);

        var header_factory = new Gtk.SignalListItemFactory ();
        header_factory.setup.connect (header_setup_func);
        header_factory.bind.connect (header_bind_func);

        var headerbar = new Gtk.HeaderBar ();

        var list_view = new Gtk.ListView (selection_model, factory) {
            header_factory = header_factory
        };

        var scrolled_window = new Gtk.ScrolledWindow () {
            child = list_view
        };

        var toolbarview = new Adw.ToolbarView () {
            content = scrolled_window
        };
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;

        var session = Notes.Session.get_default ();
        session.service_added.connect ((service) => {
            var offlinestore = (Camel.Store) service;
            offlinestore.get_folder_info.begin ("Notes", RECURSIVE, GLib.Priority.DEFAULT, null, (obj,res) => {
                try {
                    var folder_info = offlinestore.get_folder_info.end (res);
                    if (folder_info != null) {
                        list_store.append (new Notes.FoldersPane.FolderInfo (offlinestore, folder_info));

                        var child = folder_info.child;
                        while (child != null) {
                            list_store.append (new Notes.FoldersPane.FolderInfo (offlinestore, child));
                            child = child.next;
                        }
                    }
                } catch (Error e) {
                    critical (e.message);
                }
            });

            offlinestore.folder_created.connect ((folder_info) => {
                critical ("add folder_info");
                list_store.append (new Notes.FoldersPane.FolderInfo (offlinestore, folder_info));
            });
            // offlinestore.folder_deleted.connect (folder_deleted);
            // offlinestore.folder_info_stale.connect (reload_folders);
            // offlinestore.folder_renamed.connect (folder_renamed);
        });
    }

    private void setup_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        list_item.child = new Gtk.Label ("") {
            xalign = 0
        };
    }

    private void bind_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        ((Gtk.Label) list_item.child).label = ((Notes.FoldersPane.FolderInfo) list_item.item).folder_info.display_name;
    }

    private void header_setup_func (Object object) {
        var list_header = (Gtk.ListHeader) object;
        list_header.child = new Granite.HeaderLabel ("");
    }

    private void header_bind_func (Object object) {
        var list_header = (Gtk.ListHeader) object;
        ((Granite.HeaderLabel) list_header.child).label = ((Notes.FoldersPane.FolderInfo) list_header.item).store.display_name;
    }

    private class FolderInfo : Object {
        public Camel.Store store { get; construct; }
        public Camel.FolderInfo folder_info { get; construct; }

        public FolderInfo (Camel.Store store, Camel.FolderInfo folder_info) {
            Object (
                store: store,
                folder_info: folder_info
            );
        }
    }
}
