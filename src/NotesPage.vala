/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.NotesPage : Adw.NavigationPage {
    public Notes.FolderItem folder_item {
        set {
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

        var list_view = new Gtk.ListView (selection_model, factory);

        var scrolled_window = new Gtk.ScrolledWindow () {
            child = list_view
        };

        var toolbarview = new Adw.ToolbarView () {
            content = scrolled_window
        };
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;
        title = _("Notes");
        add_css_class (Granite.STYLE_CLASS_VIEW);
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
