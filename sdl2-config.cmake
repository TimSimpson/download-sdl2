include(CMakeFindDependencyMacro)
cmake_minimum_required(VERSION 3.5)

set(CMAKE_IMPORT_FILE_VERSION 2.0.8)

# Hilariously complex way to find `include` directory in prefix dir.
# Remember, this file will be in "lib/cmake/sdl2", and we want this path
# to point to "lib"'s neighbor, "include".
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

if("${CMAKE_SYSTEM_NAME}" MATCHES "Emscripten")
  # These libraries are defined to avoid build script errors, but
  # are empty as they get included with Emscripten by default.
  add_library(sdl2::sdl2 INTERFACE IMPORTED)
  add_library(sdl2::image INTERFACE IMPORTED)
  # Warning: TTF currently does not work:
  add_library(sdl2::ttf INTERFACE IMPORTED)
  add_library(sdl2::mixer INTERFACE IMPORTED)

  # TODO: This still won't work unless you set CMAKE_CXX_FLAGS as follows:
  # set(CMAKE_CXX_FLAGS
  #    "${CMAKE_CXX_FLAGS} -s USE_SDL=2 -s USE_SDL_IMAGE=2  -s SDL2_IMAGE_FORMATS='[\"png\",\"bmp\"]' ")
  # I am not sure how to set these on dependents of an imported library.
  # For now it seems like it would make users less flexible if they couldn't
  # specify details, such as the SDL2_IMAGE_FORMATS, themselves.

else()
  find_path(_INCLUDE_DIR SDL.h
    PATHS
    "${_IMPORT_PREFIX}/include/SDL2"
    "/usr/include"
    "/usr/include/SDL2"
    "/usr/local/include"
    "/usr/local/include/SDL2"
  )

  find_library(SDL2 NAMES "SDL2"
    PATHS
    "${CMAKE_CURRENT_SOURCE_DIR}/lib"
    "/usr/lib/x86_64-linux-gnu")
  add_library(sdl2::sdl2 STATIC IMPORTED)
  set_property(TARGET sdl2::sdl2 PROPERTY IMPORTED_LOCATION "${SDL2}")
  set_target_properties(sdl2::sdl2 PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${_INCLUDE_DIR}")


  find_library(SDL2_ttf NAMES "SDL2_ttf"
    PATHS
    "${CMAKE_CURRENT_SOURCE_DIR}/lib"
    "/usr/lib/x86_64-linux-gnu")
  add_library(sdl2::ttf STATIC IMPORTED)
  set_property(TARGET sdl2::ttf PROPERTY IMPORTED_LOCATION "${SDL2_ttf}")
  set_target_properties(sdl2::ttf PROPERTIES
    INTERFACE_LINK_LIBRARIES sdl2::sdl2)


  find_library(SDL2_image NAMES "SDL2_image"
    PATHS
    "${CMAKE_CURRENT_SOURCE_DIR}/lib"
    "/usr/lib/x86_64-linux-gnu")
  add_library(sdl2::image STATIC IMPORTED)
  set_property(TARGET sdl2::image PROPERTY IMPORTED_LOCATION "${SDL2_image}")
  set_target_properties(sdl2::image PROPERTIES
    INTERFACE_LINK_LIBRARIES sdl2::sdl2)


  find_library(SDL2_mixer NAMES "SDL2_mixer"
    PATHS
    "${CMAKE_CURRENT_SOURCE_DIR}/lib"
    "/usr/lib/x86_64-linux-gnu")
  add_library(sdl2::mixer STATIC IMPORTED)
  set_property(TARGET sdl2::mixer PROPERTY IMPORTED_LOCATION "${SDL2_mixer}")
  set_target_properties(sdl2::mixer PROPERTIES
    INTERFACE_LINK_LIBRARIES sdl2::sdl2)

endif()

# Cleanup temporary variables.
set(_IMPORT_PREFIX)
set(_INCLUDE_DIR)
set(SDL2)
set(SDL2_ttf)
set(SDL2_image)
set(SDL2_mixer)

set(CMAKE_IMPORT_FILE_VERSION)
