project(
    'io.elementary.notes',
    'vala', 'c',
    version: '1.0.0',
    meson_version: '>=0.58.0'
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

adw_dep = dependency('libadwaita-1')
granite_dep = dependency('granite-7')
gtk_dep = dependency('gtk4')

dependencies = [
    adw_dep,
    granite_dep,
    gtk_dep
]

gnome.post_install(
    glib_compile_schemas: true,
    gtk_update_icon_cache: true
)

subdir('data')
subdir('po')
subdir('src')
