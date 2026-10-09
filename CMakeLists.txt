cmake_minimum_required(VERSION 3.16)

project(LearnOpenGL LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# creat a executable program named hello_window
add_executable(
    hello_window

    src/01_GettingStarted/hello_window.cpp
    src/glad.c
)

# tell the compiler where to find header
target_include_directories(
    hello_window
    PRIVATE
    ${CMAKE_SOURCE_DIR}/includes
)

# Use the macOS GLFW library stored in this project.
set(GLFW_LIBRARY "${CMAKE_CURRENT_SOURCE_DIR}/lib/libglfw.3.dylib")
if(NOT EXISTS "${GLFW_LIBRARY}")
    message(FATAL_ERROR "GLFW library not found: ${GLFW_LIBRARY}")
endif()
add_library(glfw SHARED IMPORTED)
set_target_properties(glfw PROPERTIES IMPORTED_LOCATION "${GLFW_LIBRARY}")

# find OpenGL
find_package(OpenGL REQUIRED)

# link GLFW and OpenGL to the program
target_link_libraries(
    hello_window
    PRIVATE
    glfw
    OpenGL::GL
)

# The dylib uses @rpath; find it beside the source tree when running from build/.
set_target_properties(hello_window PROPERTIES
    BUILD_RPATH "${CMAKE_CURRENT_SOURCE_DIR}/lib"
)
