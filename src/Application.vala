/*
 * SPDX-License-Identifier: LGPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.Application : Gtk.Application {
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
