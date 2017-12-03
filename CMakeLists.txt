cmake_minimum_required(VERSION 3.5)

project(sdl_import)

include(CMakePackageConfigHelpers)
include(ExternalProject)

function(download_prebuilt directory url md5)
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


function(build_from_src directory url md5)
    get_filename_component(file_name "${url}" NAME)

    ExternalProject_Add("${directory}"
        URL "${url}"
        URL_MD5 "${md5}"
        DOWNLOAD_DIR "${PROJECT_BINARY_DIR}/${directory}"
        SOURCE_DIR "${PROJECT_BINARY_DIR}/${directory}"
        CONFIGURE_COMMAND "${PROJECT_BINARY_DIR}/${directory}/configure"
                          "--prefix=${PROJECT_BINARY_DIR}/install"
        BUILD_COMMAND ${MAKE})
endfunction()


if (WIN32)
    download_prebuilt(
        "SDL2-2.0.7"
        "https://www.libsdl.org/release/SDL2-devel-2.0.7-VC.zip"
        "b184cff52eb5a22c459d7943e9aeedb0"
    )

    download_prebuilt(
        "SDL2_ttf-2.0.14"
        "https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-devel-2.0.14-VC.zip"
        "304d4aa67fec7a5a8c3c47c4639b91e2"
    )

    download_prebuilt(
        "SDL2_mixer-2.0.2"
        "https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-2.0.2-VC.zip"
        "0c0fb9bead99fcbd7cc8fdbed4bcd8eb"
    )

    # SDL2_ttf downloads a version of zlib that conflicts with what SDL2_image
    # uses (yeah, I know!). So it's crucial to install SDL2_image last to
    # ensure it actually works!
    download_prebuilt(
        "SDL2_image-2.0.2"
        "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.2-VC.zip"
        "a731f9ce332f8acc0e4db1421a250ae2"
    )
else()
    file(REMOVE "${PROJECT_BINARY_DIR}/install")
    file(MAKE_DIRECTORY "${PROJECT_BINARY_DIR}/install")

    build_from_src(
        "SDL2-2.0.7"
        "https://www.libsdl.org/release/SDL2-2.0.7.tar.gz"
        "cdb071009d250e1782371049f0d5ca42"
    )
    build_from_src(
        "SDL2_ttf-2.0.14"
        "https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.14.tar.gz"
        "e53c05e1e7f1382c316afd6c763388b1"
    )
    add_dependencies("SDL2_ttf-2.0.14" "SDL2-2.0.7")
    build_from_src(
        "SDL2_mixer-2.0.2"
        "https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.2.tar.gz"
        "aaa0551393993c14a13f72b339c0ed6c"
    )
    add_dependencies("SDL2_mixer-2.0.2" "SDL2-2.0.7")
    build_from_src(
        "SDL2_image-2.0.2"
        "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.2.tar.gz"
        "d0a83b9a2ca8371a3c85aefe402ae680"
    )
    add_dependencies("SDL2_image-2.0.2" "SDL2-2.0.7")

    install(
        DIRECTORY "${PROJECT_BINARY_DIR}/install/include/SDL2/"
        DESTINATION include)
    install(
        DIRECTORY "${PROJECT_BINARY_DIR}/install/lib/"
        DESTINATION lib)
    install(
        DIRECTORY "${PROJECT_BINARY_DIR}/install/bin/"
        DESTINATION bin)
    install(
        DIRECTORY "${PROJECT_BINARY_DIR}/install/share/"
        DESTINATION share)
endif()


write_basic_package_version_file("${PROJECT_BINARY_DIR}/sdl2-config-version.cmake"
    VERSION 2.0.7
    COMPATIBILITY AnyNewerVersion
)

install(FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/sdl2-config.cmake"
    "${PROJECT_BINARY_DIR}/sdl2-config-version.cmake"
    DESTINATION lib/cmake/sdl2
)
