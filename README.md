# Download SDL2

This downloads and builds the SDL2 libraries in Linux / OSX and uses the prebuilt libraries on Windows.

It also installs a simple config file for CMake that let's you opt in to every SDL2 package.

## Usage

On Linux, you'll need to install the Free Type 2 libraries first:

    libfreetype6-dev

(Please be aware that Free Type2, used by SDL2::ttf, is GNU licensed while
 SDL2 is not.)

Using [Cget](https://github.com/pfultz2/cget), do this:

    $ cget install TimSimpson/download-sdl2

If you want to test it out, try this:

    $ git clone https://github.com/TimSimpson/download-sdl2.git
    $ cd download-sdl2
    $ mkdir build
    $ cd build
    $ cget install ../
    $ cmake -DCMAKE_TOOLCHAIN_FILE=../cget/cget/cget.cmake -H../test -B./

To use the SDL2 from your CMake project try this:

    find_package(sdl2 2.0.7)

    ...

    target_link_libraries(my_library PUBLIC sdl2::sdl2 sdl2::image)

`find_package(sdl2 2.0.7)` pulls in the CMake namespace `sdl2` which has the following members:

* sdl2::sdl2
* sdl2::image
* sdl2::mixer
* sdl2::ttf
