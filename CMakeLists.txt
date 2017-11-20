cmake_minimum_required(VERSION 3.5)

project(sdl_import)

include(CMakePackageConfigHelpers)

# add_library(sdl2 STATIC IMPORTED)
# set_property(TARGET sdl2 PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/lib/SDL2.lib)
# target_include_directories(sdl2 PUBLIC
#     $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
# )
find_library(SDL2 NAMES "SDL2" PATHS "${CMAKE_CURRENT_SOURCE_DIR}/lib")
# add_library(sdl2::sdl2 INTERFACE IMPORTED)
# set_property(TARGET sdl2::sdl2 PROPERTY IMPORTED_LOCATION "${SDL2}")

install(DIRECTORY include/ DESTINATION include)
install(FILES "${SDL2}" DESTINATION lib)
# install(TARGETS sdl2::sdl2 EXPORT sdl2-targets
#     RUNTIME DESTINATION bin
#     LIBRARY DESTINATION lib
#     ARCHIVE DESTINATION lib
#     INCLUDES DESTINATION include
# )

# add_library(sdl2::sdl2 ALIAS sdl2)
# install(EXPORT sdl2-targets
#     FILE sdl2-targets.cmake
#     NAMESPACE sdl2::
#     DESTINATION lib/cmake/sdl2
# )

# file(WRITE "${PROJECT_BINARY_DIR}/sdl2-config.cmake" "
# include(CMakeFindDependencyMacro)
# # include(\"\${CMAKE_CURRENT_LIST_DIR}/sdl2-targets.cmake\")
# ")


write_basic_package_version_file("${PROJECT_BINARY_DIR}/sdl2-config-version.cmake"
    VERSION 2.0.7
    COMPATIBILITY AnyNewerVersion
)

install(FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/sdl2-config.cmake"
    "${PROJECT_BINARY_DIR}/sdl2-config-version.cmake"
    DESTINATION lib/cmake/sdl2
)
