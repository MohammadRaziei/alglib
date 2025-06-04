# Specify the minimum required version of CMake
cmake_minimum_required(VERSION 3.15)

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
add_library(alglib_static STATIC ${ALGLIB_SOURCES})
target_include_directories(alglib_static PUBLIC ${ALGLIB_INCLUDE_DIR})

# Create an alias for the static library
add_library(alglib::static ALIAS alglib_static)

# Create a shared library target
add_library(alglib_shared SHARED ${ALGLIB_SOURCES})
target_include_directories(alglib_shared PUBLIC ${ALGLIB_INCLUDE_DIR})

# Create an alias for the shared library
add_library(alglib::shared ALIAS alglib_shared)


# Enable testing for the project
enable_testing()

# List of test names
set(ALGLIB_TESTS c i x xpart0)

# Check if CMAKE_SOURCE_DIR and PROJECT_SOURCE_DIR are the same
if(CMAKE_SOURCE_DIR STREQUAL PROJECT_SOURCE_DIR)
    message(STATUS "CMAKE_SOURCE_DIR and PROJECT_SOURCE_DIR are the same. Tests will be added.")

    # Add executables and tests for each test file
    foreach(ALGLIB_TEST_NAME ${ALGLIB_TESTS})
        # Define the source file path
        set(ALGLIB_TEST_SOURCE "${PROJECT_SOURCE_DIR}/tests/test_${ALGLIB_TEST_NAME}.cpp")

        # Add the executable
        add_executable(alglib_test_${ALGLIB_TEST_NAME} ${ALGLIB_TEST_SOURCE})

        # Link the static library
        target_link_libraries(alglib_test_${ALGLIB_TEST_NAME} PRIVATE alglib::static)

        # Define the required macro
        target_compile_definitions(alglib_test_${ALGLIB_TEST_NAME} PRIVATE AE_DEBUG4POSIX)

        # Register the test with CTest
        add_test(
            NAME alglib_test_${ALGLIB_TEST_NAME}
            COMMAND alglib_test_${ALGLIB_TEST_NAME}
        )

        # Print a status message
        message(STATUS "Test executable 'alglib_test_${ALGLIB_TEST_NAME}' has been added.")
    endforeach()
else()
    message(WARNING "CMAKE_SOURCE_DIR and PROJECT_SOURCE_DIR are different. Skipping test setup.")
endif()


# Install targets
install(TARGETS alglib_static
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
)

install(TARGETS alglib_shared
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
)

install(DIRECTORY ${ALGLIB_INCLUDE_DIR}/ DESTINATION include)

# Print project information
message(STATUS "Building ALGLIB version: ${PROJECT_VERSION}")