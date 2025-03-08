/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.FoldersPane : Granite.Bin {
    construct {
        var headerbar = new Gtk.HeaderBar ();

        var toolbarview = new Adw.ToolbarView ();
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;

        var session = Notes.Session.get_default ();
        foreach (unowned var service in session.list_services ()) {
            critical (service.dup_display_name ());
        }

        session.service_added.connect ((service) => {
            critical (service.display_name);
        });
    }
}
