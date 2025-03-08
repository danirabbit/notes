/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.Session : Camel.Session {
    public signal void service_added (Camel.Service service);

    private static GLib.Once<Notes.Session> instance;
    public static unowned Notes.Session get_default () {
        return instance.once (() => { return new Notes.Session (); });
    }

    private E.SourceRegistry? registry = null;

    private Session () {
        Object (
            user_data_dir: Path.build_filename (E.get_user_data_dir (), "notes"),
            user_cache_dir: Path.build_filename (E.get_user_cache_dir (), "notes")
        );
    }

    construct {
        Camel.init (E.get_user_data_dir (), false);

        unowned var network_monitor = E.NetworkMonitor.get_default ();
        set_network_monitor (network_monitor);

        network_monitor.network_changed.connect (set_online);
        set_online (true);

        init.begin ();
    }

    private async void init () {
        if (registry != null) {
            debug ("Camel.Session is already started.");
            return;
        }

        try {
            registry = yield new E.SourceRegistry (null);
        } catch (Error e) {
            critical (e.message);
            return;
        }

        var sources = registry.list_sources (E.SOURCE_EXTENSION_MAIL_ACCOUNT);
        sources.foreach (add_source);

        registry.source_added.connect (add_source);
    }

    private void add_source (E.Source source) {
        unowned string uid = source.get_uid ();
        if (uid == "vfolder") {
            return;
        }

        if (!source.has_extension (E.SOURCE_EXTENSION_MAIL_ACCOUNT)) {
            return;
        }
        unowned var extension = (E.SourceMailAccount) source.get_extension (E.SOURCE_EXTENSION_MAIL_ACCOUNT);

        try {
            add_service (uid, extension.backend_name, Camel.ProviderType.STORE);
        } catch (Error e) {
            critical (e.message);
        }
    }

    public override Camel.Service add_service (string uid, string protocol, Camel.ProviderType type) throws GLib.Error {
        var service = base.add_service (uid, protocol, type);
        if (service is Camel.Service) {
            var source = registry.ref_source (uid);
            unowned string extension_name = E.SourceCamel.get_extension_name (protocol);
            var extension_source = registry.find_extension (source, extension_name);
            if (extension_source != null) {
                source = extension_source;
            }

            /* This handles all the messy property bindings. */
            source.camel_configure_service (service);
            source.bind_property ("display-name", service, "display-name", SYNC_CREATE);
            if (service is Camel.OfflineStore) {
                service_added (service);
            }
        }

        return service;
    }
}
