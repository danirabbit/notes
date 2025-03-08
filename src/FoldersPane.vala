/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.FoldersPane : Granite.Bin {
    construct {
        var list_store = new GLib.ListStore (typeof (Camel.Service));
        var selection_model = new Gtk.NoSelection (list_store);

        var factory = new Gtk.SignalListItemFactory ();
        factory.setup.connect (setup_func);
        factory.bind.connect (bind_func);

        var headerbar = new Gtk.HeaderBar ();

        var list_view = new Gtk.ListView (selection_model, factory);

        var scrolled_window = new Gtk.ScrolledWindow () {
            child = list_view
        };

        var toolbarview = new Adw.ToolbarView () {
            content = scrolled_window
        };
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;

        var session = Notes.Session.get_default ();
        session.service_added.connect (list_store.append);
    }

    private void bind_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        ((Granite.HeaderLabel) list_item.child).label = ((Camel.Service) list_item.item).display_name;
    }

    private void setup_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        list_item.child = new Granite.HeaderLabel ("");
    }
}
