install_data(
    'notes.gschema.xml',
    install_dir: get_option('datadir') / 'glib-2.0' / 'schemas',
    rename: meson.project_name() + '.gschema.xml'
)

i18n.merge_file(
    input: 'notes.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: meson.project_source_root() / 'po' / 'extra',
    type: 'desktop',
    install: true,
    install_dir: get_option('datadir') / 'applications'
)

gresource = gnome.compile_resources(
    'notes-resources',
    'notes.gresource.xml',
    source_dir: 'styles'
)

subdir('icons')
