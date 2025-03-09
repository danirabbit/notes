/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.MainWindow : Adw.ApplicationWindow {
    construct {
        var folders_page = new FoldersPage ();
        var notes_page = new NotesPage ();

        var nav_split_view = new Adw.NavigationSplitView () {
            content = notes_page,
            sidebar = folders_page,
            show_content = true
        };

        var nav_page = new Adw.NavigationPage (nav_split_view, "navigation");

        var editor_page = new EditorPage ();

        var content_split_view = new Adw.NavigationSplitView () {
            content = editor_page,
            sidebar = nav_page,
            show_content = true,
            max_sidebar_width = 800,
            min_sidebar_width = 45,
            sidebar_width_fraction = 0.5
        };

        var outer_breakpoint = new Adw.Breakpoint (
            new Adw.BreakpointCondition.length (MAX_WIDTH, 860, SP)
        );
        outer_breakpoint.add_setters (
            nav_split_view, "collapsed", true,
            content_split_view, "sidebar-width-fraction", 0.33
        );

        var inner_breakpoint = new Adw.Breakpoint (
            new Adw.BreakpointCondition.length (MAX_WIDTH, 500, SP)
        );
        inner_breakpoint.add_setters (
            nav_split_view, "collapsed", true,
            content_split_view, "sidebar-width-fraction", 0.33,
            content_split_view, "collapsed", true
        );

        content = content_split_view;
        height_request = 200;
        width_request = 200;
        add_breakpoint (outer_breakpoint);
        add_breakpoint (inner_breakpoint);

        folders_page.row_activated.connect ((folder_item) => {
            notes_page.folder_item = folder_item;
            nav_split_view.show_content = true;
        });

        notes_page.row_activated.connect ((folder, message_info) => {
            content_split_view.show_content = true;
            editor_page.open_message.begin (folder, message_info);
        });
    }
}
