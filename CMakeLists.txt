cmake_minimum_required(VERSION 3.5)

project(sdl_import)

include(CMakePackageConfigHelpers)


if (WIN32)
    function(download_component directory url md5)
        get_filename_component(file_name "${url}" NAME)
        file(DOWNLOAD
            "${url}"
            "${PROJECT_BINARY_DIR}/${file_name}"
             SHOW_PROGRESS
             EXPECTED_MD5 "${md5}")
        file(REMOVE [file1 ...])
        execute_process(
            WORKING_DIRECTORY "${PROJECT_BINARY_DIR}"
            COMMAND ${CMAKE_COMMAND} -E tar xvf "${PROJECT_BINARY_DIR}/${file_name}"
        )

        install(
            DIRECTORY "${PROJECT_BINARY_DIR}/${directory}/include/"
            DESTINATION include)

        if ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
            install(
                DIRECTORY "${PROJECT_BINARY_DIR}/${directory}/lib/x86/"
                DESTINATION lib)
        elseif ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "8")
            install(
                DIRECTORY "${PROJECT_BINARY_DIR}/${directory}/lib/x64/"
                DESTINATION lib)
        else()
            message(FATAL_ERROR "Architecture unknown.")
        endif()

    endfunction()

    # Download SDL

    download_component(
        "SDL2-2.0.7"
        "https://www.libsdl.org/release/SDL2-devel-2.0.7-VC.zip"
        "b184cff52eb5a22c459d7943e9aeedb0"
    )

    download_component(
        "SDL2_image-2.0.2"
        "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.2-VC.zip"
        "a731f9ce332f8acc0e4db1421a250ae2"
    )

    download_component(
        "SDL2_ttf-2.0.14"
        "https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-devel-2.0.14-VC.zip"
        "304d4aa67fec7a5a8c3c47c4639b91e2"
    )

    download_component(
        "SDL2_mixer-2.0.2"
        "https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-2.0.2-VC.zip"
        "0c0fb9bead99fcbd7cc8fdbed4bcd8eb"
    )
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
