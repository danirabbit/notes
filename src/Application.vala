/*
 * SPDX-License-Identifier: LGPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.Application : Gtk.Application {
    public Application () {
        Object (
            application_id: "io.elementary.notes",
            flags: ApplicationFlags.DEFAULT_FLAGS
        );
    }

    construct {
        GLib.Intl.setlocale (LocaleCategory.ALL, "");
        GLib.Intl.bindtextdomain (application_id, Constants.LOCALEDIR);
        GLib.Intl.bind_textdomain_codeset (application_id, "UTF-8");
        GLib.Intl.textdomain (application_id);
    }

    protected override void activate () {
        if (active_window != null) {
            active_window.present ();
            return;
        }

        var main_window = new Gtk.ApplicationWindow (this) {
            title = _("Notes")
        };
        main_window.present ();

        add_window (main_window);
    }

    public static int main (string[] args) {
        return new Notes.Application ().run (args);
    }
}
