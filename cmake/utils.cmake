# Define a function to generate the library file name
function(generate_library_name LIB_NAME IS_SHARED OUTPUT_VAR)
    # Check the operating system
    if(WIN32)
        set(LIB_PREFIX "")   # No prefix on Windows
        if(IS_SHARED)
            set(LIB_SUFFIX ".dll")  # Shared library on Windows
        else()
            set(LIB_SUFFIX ".lib")  # Static library on Windows
        endif()
    elseif(APPLE)
        set(LIB_PREFIX "lib")  # Prefix for macOS
        if(IS_SHARED)
            set(LIB_SUFFIX ".dylib")  # Shared library on macOS
        else()
            set(LIB_SUFFIX ".a")     # Static library on macOS
        endif()
    else()
        set(LIB_PREFIX "lib")  # Prefix for Linux/Unix
        if(IS_SHARED)
            set(LIB_SUFFIX ".so")  # Shared library on Linux/Unix
        else()
            set(LIB_SUFFIX ".a")   # Static library on Linux/Unix
        endif()
    endif()

    # Generate the full library file name
    set(FULL_LIB_NAME "${LIB_PREFIX}${LIB_NAME}${LIB_SUFFIX}")

    # Return the result via the output variable
    set(${OUTPUT_VAR} ${FULL_LIB_NAME} PARENT_SCOPE)
endfunction()