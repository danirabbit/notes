/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.NotesPage : Adw.NavigationPage {
    public Notes.FolderItem folder_item {
        set {
            critical (value.info.display_name);
        }
    }

    construct {
        var headerbar = new Adw.HeaderBar () {
            show_title = false
        };

        var list_view = new Gtk.ListView (null, null);

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
}
