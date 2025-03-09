# Notes
![Mail Screenshot](data/screenshot.png?raw=true)

## Building, Testing, and Installation

You'll need the following dependencies:
* libadwaita-1
* camel-1.2 >= 3.28
* libedataserver-1.2 >= 3.28
* libedataserverui4-1.0 >=3.45.1'
* granite-7 >= 7.6.0
* gtk4
* meson
* valac

Run `meson build` to configure the build environment and then change to the build directory and run `ninja` to build

    meson build --prefix=/usr
    cd build
    ninja

To install, use `ninja install`, then execute with `io.elementary.notes`

    ninja install
    io.elementary.notes
