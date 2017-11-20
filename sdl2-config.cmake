include(CMakeFindDependencyMacro)
cmake_minimum_required(VERSION 3.5)

set(CMAKE_IMPORT_FILE_VERSION 2.0.7)

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

find_library(SDL2 NAMES "SDL2" PATHS "${CMAKE_CURRENT_SOURCE_DIR}/lib")
add_library(sdl2::sdl2 STATIC IMPORTED)
set_property(TARGET sdl2::sdl2 PROPERTY IMPORTED_LOCATION "${SDL2}")
set_target_properties(sdl2::sdl2 PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include")


find_library(SDL2_ttf NAMES "SDL2_ttf" PATHS "${CMAKE_CURRENT_SOURCE_DIR}/lib")
add_library(sdl2::ttf STATIC IMPORTED)
set_property(TARGET sdl2::ttf PROPERTY IMPORTED_LOCATION "${SDL2_ttf}")
set_target_properties(sdl2::ttf PROPERTIES
  INTERFACE_LINK_LIBRARIES sdl2::sdl2)


find_library(SDL2_image NAMES "SDL2_image" PATHS "${CMAKE_CURRENT_SOURCE_DIR}/lib")
add_library(sdl2::image STATIC IMPORTED)
set_property(TARGET sdl2::image PROPERTY IMPORTED_LOCATION "${SDL2_image}")
set_target_properties(sdl2::image PROPERTIES
  INTERFACE_LINK_LIBRARIES sdl2::sdl2)


find_library(SDL2_mixer NAMES "SDL2_mixer" PATHS "${CMAKE_CURRENT_SOURCE_DIR}/lib")
add_library(sdl2::mixer STATIC IMPORTED)
set_property(TARGET sdl2::mixer PROPERTY IMPORTED_LOCATION "${SDL2_mixer}")
set_target_properties(sdl2::mixer PROPERTIES
  INTERFACE_LINK_LIBRARIES sdl2::sdl2)

# Cleanup temporary variables.
set(_IMPORT_PREFIX)

set(CMAKE_IMPORT_FILE_VERSION)
