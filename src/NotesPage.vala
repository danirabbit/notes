/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.NotesPage : Adw.NavigationPage {
    public signal void row_activated (Camel.Folder folder, Camel.MessageInfo message_info);

    private Notes.FolderItem? _folder_item = null;
    public Notes.FolderItem folder_item {
        get {
            return _folder_item;
        }
        set {
            _folder_item = value;
            selection_model.model = value.message_infos;
        }
    }

    private Gtk.NoSelection selection_model;

    construct {
        selection_model = new Gtk.NoSelection (null);

        var factory = new Gtk.SignalListItemFactory ();
        factory.setup.connect (setup_func);
        factory.bind.connect (bind_func);

        var headerbar = new Adw.HeaderBar () {
            show_title = false
        };

        var list_view = new Gtk.ListView (selection_model, factory) {
            single_click_activate = true
        };

        var scrolled_window = new Gtk.ScrolledWindow () {
            child = list_view
        };

        var toolbarview = new Adw.ToolbarView () {
            content = scrolled_window
        };
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;
        title = _("Notes");

        list_view.activate.connect ((pos) => {
            row_activated (folder_item.folder, (Camel.MessageInfo) selection_model.get_item (pos));
        });
    }

    private void setup_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        list_item.child = new Gtk.Label (null) {
            xalign = 0
        };
    }

    private void bind_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        ((Gtk.Label) list_item.child).label = ((Camel.MessageInfo) list_item.item).subject;
    }
}
