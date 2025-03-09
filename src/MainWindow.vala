/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.MainWindow : Gtk.ApplicationWindow {
    construct {
        var folders_page = new FoldersPage ();
        var notes_page = new NotesPage ();

        var split_view = new Adw.NavigationSplitView () {
            content = notes_page,
            sidebar = folders_page
        };

        child = split_view;

        titlebar = new Gtk.Grid () { visible = false };

        folders_page.folder_activated.connect ((folder_item) => {
            notes_page.folder_item = folder_item;
        });
    }
}
