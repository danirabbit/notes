project(
    'io.elementary.notes',
    'vala', 'c',
    version: '1.0.0',
    meson_version: '>=0.58.0'
)

i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

granite_dep = dependency('granite-7')
gtk_dep = dependency('gtk4')

dependencies = [
    granite_dep,
    gtk_dep
]

subdir('data')
subdir('po')
subdir('src')
