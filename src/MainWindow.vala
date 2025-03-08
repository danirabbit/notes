/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.MainWindow : Gtk.ApplicationWindow {
    construct {
        var headerbar = new Gtk.HeaderBar ();

        var toolbarview = new Adw.ToolbarView ();
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;
        titlebar = new Gtk.Grid () { visible = false };
    }
}
