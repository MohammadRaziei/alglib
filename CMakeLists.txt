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


# Add test executable
# List of test files and their corresponding executable names
set(ALGLIB_TEST_FILES
    test_c test_i test_x test_xpart0
)

# Add executables for each test file
foreach(ALGLIB_TEST_NAME ${ALGLIB_TEST_FILES})
    # Define the source file path
    set(ALGLIB_TEST_SOURCE "${PROJECT_SOURCE_DIR}/tests/${ALGLIB_TEST_NAME}.cpp")

    # Add the executable
    add_executable(alglib_${ALGLIB_TEST_NAME} ${ALGLIB_TEST_SOURCE})

    # Link the static library
    target_link_libraries(alglib_${ALGLIB_TEST_NAME} PRIVATE alglib::static)

    # Define the required macro
    target_compile_definitions(alglib_${ALGLIB_TEST_NAME} PRIVATE AE_DEBUG4POSIX)

    # Print a status message
    message(STATUS "Test executable 'alglib_${ALGLIB_TEST_NAME}' has been added.")
endforeach()

# target_compile_definitions(alglib_test_xne PRIVATE AE_NO_EXCEPTIONS AE_THREADING=AE_SERIAL_UNSAFE)

message(STATUS "Test executable 'tests' has been added.")


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