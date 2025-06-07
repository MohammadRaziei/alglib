# Specify the project configuration
CONFIG += c++17

# Define source and include directories
ALGLIB_SOURCE_DIR = $$PWD/src
ALGLIB_INCLUDE_DIR = $$PWD/src

# Collect source files
ALGLIB_SOURCES = $$files($$ALGLIB_SOURCE_DIR/*.cpp)
ALGLIB_HEADERS = $$files($$ALGLIB_INCLUDE_DIR/*.h)

# Add sources and headers to the project
SOURCES += $$ALGLIB_SOURCES
HEADERS += $$ALGLIB_HEADERS

# Include directories
INCLUDEPATH += $$ALGLIB_INCLUDE_DIR

# Define the required macro based on the operating system
win32 {
    DEFINES += AE_OS=AE_WINDOWS
} else {
    DEFINES += AE_OS=AE_POSIX
}

# Link the static library (if needed)
LIBS += -L$$OUT_PWD/libs -lalglib