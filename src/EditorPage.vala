/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 elementary, Inc. (https://elementary.io)
 */

public class Notes.EditorPage : Adw.NavigationPage {
    private WebKit.WebView web_view;

    construct {
        var headerbar = new Adw.HeaderBar ();

        web_view = new WebKit.WebView ();

        var toolbarview = new Adw.ToolbarView () {
            content = web_view
        };
        toolbarview.add_top_bar (headerbar);

        child = toolbarview;
        add_css_class (Granite.STYLE_CLASS_VIEW);
    }

    public async void open_message (Camel.MimeMessage message) {
        title = message.get_subject ();
        var message_content = yield handle_text_mime (message.content);
        if (message_content == "") {
            return;
        }

        web_view.load_html (message_content, "elementary-notes:body");
    }

    private async string handle_text_mime (Camel.DataWrapper part) {
        var field = part.get_mime_type_field ();
        var os = new GLib.MemoryOutputStream.resizable ();
        try {
            yield part.decode_to_output_stream (os, GLib.Priority.DEFAULT, null);
            os.close ();
        } catch (Error e) {
            warning ("Possible error decoding email message: %s", e.message);
            return "";
        }

        // Convert the message to UTF-8 to ensure we have a valid GLib string.
        return convert_to_utf8 (os, field.param ("charset"));
    }

    private static string convert_to_utf8 (GLib.MemoryOutputStream os, string? encoding) {
        var num_bytes = (int) os.get_data_size ();
        var bytes = (string) os.steal_data ();

        string? utf8 = null;

        if (encoding != null) {
            string? iconv_encoding = Camel.iconv_charset_name (encoding);
            if (iconv_encoding != null) {
                try {
                    utf8 = GLib.convert (bytes, num_bytes, "UTF-8", iconv_encoding);
                } catch (ConvertError e) {
                    // Nothing to do - result will be assigned below.
                }
            }
        }

        if (utf8 == null || !utf8.validate ()) {
            /*
             * If message_content is not valid UTF-8 at this point, assume that
             * it is ISO-8859-1 encoded by default, and convert it to UTF-8.
             */
            try {
                utf8 = GLib.convert (bytes, num_bytes, "UTF-8", "ISO-8859-1");
            } catch (ConvertError e) {
                critical ("Every string should be valid ISO-8859-1. ConvertError: %s", e.message);
                utf8 = "";
            }
        }

        return utf8;
    }
}
