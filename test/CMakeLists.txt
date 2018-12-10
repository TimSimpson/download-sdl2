cmake_minimum_required(VERSION 3.5)
project(cget_sdl_example CXX)

find_package(sdl2 2.0.8)

add_executable(sdl_test ${CMAKE_CURRENT_SOURCE_DIR}/src/sdl_test.cpp)
target_link_libraries(sdl_test sdl2::sdl2)
add_test(sdl_test sdl_test)

add_executable(sdl_image_test ${CMAKE_CURRENT_SOURCE_DIR}/src/sdl_image_test.cpp)
target_link_libraries(sdl_image_test sdl2::sdl2 sdl2::image)
add_test(sdl_image_test sdl_image_test)

add_executable(sdl_ttf_test ${CMAKE_CURRENT_SOURCE_DIR}/src/sdl_ttf_test.cpp)
target_link_libraries(sdl_ttf_test sdl2::sdl2 sdl2::ttf)
add_test(sdl_ttf_test sdl_ttf_test)

add_executable(sdl_mixer_test ${CMAKE_CURRENT_SOURCE_DIR}/src/sdl_mixer_test.cpp)
target_link_libraries(sdl_mixer_test sdl2::sdl2 sdl2::mixer)
add_test(sdl_mixer_test sdl_mixer_test)
