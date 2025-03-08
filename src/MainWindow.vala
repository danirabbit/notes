/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.MainWindow : Gtk.ApplicationWindow {
    construct {
        child = new FoldersPane ();
        titlebar = new Gtk.Grid () { visible = false };
    }
}
