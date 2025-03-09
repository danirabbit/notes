/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.FoldersPane : Granite.Bin {
    construct {
        var selection_model = new Gtk.NoSelection (Notes.Session.get_default ().folder_items);

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
        add_css_class (Granite.STYLE_CLASS_SIDEBAR);
    }

    private void setup_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        list_item.child = new FolderItemChild ();
    }

    private void bind_func (Object object) {
        var list_item = (Gtk.ListItem) object;
        ((FolderItemChild) list_item.child).folder_info = (Notes.FolderItem) list_item.item;
    }

    private void header_setup_func (Object object) {
        var list_header = (Gtk.ListHeader) object;
        list_header.child = new Granite.HeaderLabel ("");
    }

    private void header_bind_func (Object object) {
        var list_header = (Gtk.ListHeader) object;
        ((Granite.HeaderLabel) list_header.child).label = ((Notes.FolderItem) list_header.item).store.display_name;
    }

    private class FolderItemChild : Gtk.Box {
        public Notes.FolderItem folder_info {
            set {
                label.label = value.info.display_name;
            }
        }

        private Gtk.Label label;

        class construct {
            set_css_name ("folder-item-child");
        }

        construct {
            var folder_image = new Gtk.Image.from_icon_name ("folder");

            label = new Gtk.Label (null);

            append (folder_image);
            append (label);
        }
    }
}
