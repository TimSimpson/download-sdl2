cmake_minimum_required(VERSION 3.5)
project(cget_sdl_example CXX)

find_package(sdl2 2.0.7)

add_executable(sdl_test ${CMAKE_CURRENT_SOURCE_DIR}/src/sdl_test.cpp)
target_link_libraries(sdl_test sdl2::sdl2)
