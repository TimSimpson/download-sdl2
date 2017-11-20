# Download SDL2

This is a simple config file for CMake that lets you find SDL2 with the find package command. It also downloads the SDL2 if you're on Windows.

## Usage

Using [Cget](https://github.com/pfultz2/cget), do this:

    $ cget install TimSimpson/download-sdl2

If you want to test it out, try this:

    $ git clone https://github.com/TimSimpson/download-sdl2.git
    $ cd download-sdl2
    $ mkdir build
    $ cd build
    $ cget install ../
    $ cmake -DCMAKE_TOOLCHAIN_FILE=../cget/cget/cget.cmake -H../test -B./
