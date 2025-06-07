# Specify the minimum required version of CMake
cmake_minimum_required(VERSION 3.15)

option(ENABLE_TESTING "Enable testing for the project" ON)

# Define the project name, version, and language
project(ALGLIB VERSION 4.0.4 LANGUAGES CXX)

# Set the C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Define source and include directories
set(ALGLIB_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(ALGLIB_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")

# Collect source files
file(GLOB ALGLIB_SOURCES "${ALGLIB_SOURCE_DIR}/*.cpp")
file(GLOB ALGLIB_HEADERS "${ALGLIB_INCLUDE_DIR}/*.h")

# Create a static library target
if (DEFINED ALGLIB_SHARED_LIBRARY)
    add_library(alglib SHARED ${ALGLIB_SOURCES})
else()
    set(ALGELIB_STATIC_LIBRARY)
    add_library(alglib STATIC ${ALGLIB_SOURCES})
endif()  

target_include_directories(alglib PUBLIC ${ALGLIB_INCLUDE_DIR})

# Check if CMAKE_SOURCE_DIR and PROJECT_SOURCE_DIR are the same
if(CMAKE_SOURCE_DIR STREQUAL PROJECT_SOURCE_DIR)
    # Set a variable to indicate that the project is top-level
    set(PROJECT_IS_TOP_LEVEL TRUE CACHE INTERNAL "Indicates if the project is top-level")
    message(STATUS "Project is top-level.")
else()
    # Set a variable to indicate that the project is not top-level
    set(PROJECT_IS_TOP_LEVEL FALSE CACHE INTERNAL "Indicates if the project is top-level")
    message(STATUS "Project is not top-level.")
endif()


if(PROJECT_IS_TOP_LEVEL AND ENABLE_TESTING)
    message(STATUS "ALGLIB tests will be added.")

    # Enable testing for the project
    enable_testing()

    # List of test names
    set(ALGLIB_TESTS c i x xpart0)

    # Add executables and tests for each test file
    foreach(ALGLIB_TEST_NAME ${ALGLIB_TESTS})
        # Define the source file path
        set(ALGLIB_TEST_SOURCE "${PROJECT_SOURCE_DIR}/tests/test_${ALGLIB_TEST_NAME}.cpp")

        # Add the executable
        add_executable(alglib_test_${ALGLIB_TEST_NAME} ${ALGLIB_TEST_SOURCE})

        # Link the static library
        target_link_libraries(alglib_test_${ALGLIB_TEST_NAME} PRIVATE alglib)

        # Define the required macro based on the operating system
        if(WIN32)
            target_compile_definitions(alglib_test_${ALGLIB_TEST_NAME} PRIVATE AE_DEBUG4WINDOWS)
        else()
            target_compile_definitions(alglib_test_${ALGLIB_TEST_NAME} PRIVATE AE_DEBUG4POSIX)
        endif()

        # Register the test with CTest
        add_test(
            NAME alglib_test_${ALGLIB_TEST_NAME}
            COMMAND alglib_test_${ALGLIB_TEST_NAME}
        )

        # Print a status message
        message(STATUS "Test executable 'alglib_test_${ALGLIB_TEST_NAME}' has been added.")
    endforeach()
endif()

# Install targets
install(TARGETS alglib
    LIBRARY DESTINATION libs  # For shared libraries (.so, .dll)
    ARCHIVE DESTINATION libs  # For static libraries (.a, .lib)
    RUNTIME DESTINATION libs  # For executables on Windows (.dll)
)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/src/ DESTINATION includes
    FILES_MATCHING PATTERN "*.h"
)


# install(DIRECTORY ${ALGLIB_INCLUDE_DIR}/ DESTINATION include)

# Print project information
message(STATUS "Building ALGLIB version: ${PROJECT_VERSION}")