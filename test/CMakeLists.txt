cmake_minimum_required(VERSION 3.5)
project(cget_sdl_example CXX)

find_package(sdl2 2.0.7)

add_executable(sdl_test ${CMAKE_CURRENT_SOURCE_DIR}/src/sdl_test.cpp)
target_link_libraries(sdl_test sdl2::sdl2)

if (WIN32)
    get_property(sdl2_lib_file TARGET sdl2::sdl2 PROPERTY IMPORTED_LOCATION)
    get_filename_component(sdl2_dll_file "${sdl2_lib_file}" NAME_WE)
    get_filename_component(sdl2_dll_dir "${sdl2_lib_file}" DIRECTORY)
    file(COPY "${sdl2_lib_file}" DESTINATION ${CMAKE_BINARY_DIR}/Debug)
    file(COPY "${sdl2_dll_dir}/${sdl2_dll_file}.dll" DESTINATION ${CMAKE_BINARY_DIR}/Debug)
endif()
