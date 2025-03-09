project(
    'io.elementary.notes',
    'vala', 'c',
    version: '1.0.0',
    meson_version: '>=0.58.0'
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

adw_dep = dependency('libadwaita-1', version: '>=1.4')
camel_dep = dependency('camel-1.2', version: '>= 3.28')
edataserver_dep = dependency('libedataserver-1.2', version: '>= 3.28')
edataserverui_dep = dependency('libedataserverui4-1.0', version: '>=3.45.1')
granite_dep = dependency('granite-7', version: '>=7.6.0')
gtk_dep = dependency('gtk4')
webkit_dep = dependency('webkitgtk-6.0')

dependencies = [
    adw_dep,
    camel_dep,
    edataserver_dep,
    edataserverui_dep,
    granite_dep,
    gtk_dep,
    webkit_dep
]

gnome.post_install(
    glib_compile_schemas: true,
    gtk_update_icon_cache: true
)

subdir('data')
subdir('po')
subdir('src')
