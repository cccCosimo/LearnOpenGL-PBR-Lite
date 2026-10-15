cmake_minimum_required(VERSION 3.16)

project(LearnOpenGL LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Use the macOS GLFW library stored in this project.
set(GLFW_LIBRARY "${CMAKE_CURRENT_SOURCE_DIR}/lib/libglfw.3.dylib")
if(NOT EXISTS "${GLFW_LIBRARY}")
    message(FATAL_ERROR "GLFW library not found: ${GLFW_LIBRARY}")
endif()
add_library(glfw SHARED IMPORTED)
set_target_properties(glfw PROPERTIES IMPORTED_LOCATION "${GLFW_LIBRARY}")

# find OpenGL
find_package(OpenGL REQUIRED)

add_library(glad STATIC src/glad.c)
target_include_directories(glad PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/includes")



# Each source file has its own main(), so build separate programs.
foreach(example IN ITEMS shaders_class)
    add_executable(${example} "src/01_GettingStarted/shader/shaders_class/${example}.cpp")
    target_link_libraries(${example} PRIVATE glad glfw OpenGL::GL)
    # GLFW's install name is @rpath/libglfw.3.dylib.
    set_target_properties(${example} PROPERTIES
        BUILD_RPATH "${CMAKE_CURRENT_SOURCE_DIR}/lib"
    )
    target_compile_definitions(shaders_class PRIVATE
    SHADER_DIR=\"${CMAKE_CURRENT_SOURCE_DIR}/src/01_GettingStarted/shader/shaders_class\"
    )
endforeach()
