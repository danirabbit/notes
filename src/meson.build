sources = [
    'Application.vala',
    'FoldersPane.vala',
    'MainWindow.vala',
    'Backend' / 'Session.vala'
]

config_data = configuration_data()
config_data.set_quoted('LOCALEDIR', get_option('prefix') / get_option('localedir'))
config_file = configure_file(
    input: 'Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

executable(
    meson.project_name(),
    sources,
    config_file,
    dependencies: dependencies,
    install: true
)
