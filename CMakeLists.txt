cmake_minimum_required(VERSION 3.5)

project(sdl_import)

include(CMakePackageConfigHelpers)



file(DOWNLOAD
    "https://www.libsdl.org/release/SDL2-devel-2.0.7-VC.zip"
    "${PROJECT_BINARY_DIR}/SDL2-devel-2.0.7-VC.zip"
     SHOW_PROGRESS
     EXPECTED_MD5 "b184cff52eb5a22c459d7943e9aeedb0")
file(REMOVE [file1 ...])
execute_process(
    WORKING_DIRECTORY "${PROJECT_BINARY_DIR}"
    COMMAND ${CMAKE_COMMAND} -E tar xvf "${PROJECT_BINARY_DIR}/SDL2-devel-2.0.7-VC.zip"
)

install(DIRECTORY "${PROJECT_BINARY_DIR}/SDL2-2.0.7/include/" DESTINATION include)

if ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
    install(DIRECTORY "${PROJECT_BINARY_DIR}/SDL2-2.0.7/lib/x86/" DESTINATION lib)
elseif ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "8")
    install(DIRECTORY "${PROJECT_BINARY_DIR}/SDL2-2.0.7/lib/x64/" DESTINATION lib)
else()
    message(FATAL_ERROR "Architecture unknown.")
endif()


# Turn off ridiculous defect that forces are library into 32 bit mode.
set(_old_cmake_sizeof_void_p "${CMAKE_SIZEOF_VOID_P}")
# Force 64-bit
set(CMAKE_SIZEOF_VOID_P "")
write_basic_package_version_file("${PROJECT_BINARY_DIR}/sdl2-config-version.cmake"
    VERSION 2.0.7
    COMPATIBILITY AnyNewerVersion
)
set(CMAKE_SIZEOF_VOID_P "${_old_cmake_sizeof_void_p}")

install(FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/sdl2-config.cmake"
    "${PROJECT_BINARY_DIR}/sdl2-config-version.cmake"
    DESTINATION lib/cmake/sdl2
)
