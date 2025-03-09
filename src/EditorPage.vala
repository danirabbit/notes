/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.EditorPage : Adw.NavigationPage {
    construct {
        var headerbar = new Adw.HeaderBar ();

        var scrolled_window = new Gtk.ScrolledWindow ();

        var toolbarview = new Adw.ToolbarView () {
            content = scrolled_window
        };
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;
    }
}
