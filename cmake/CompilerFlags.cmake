# Core set of warnings
set(cxx_warnings "-Wall")
set(cxx_warnings "${cxx_warnings} -Wextra")
set(cxx_warnings "${cxx_warnings} -Wpedantic")
set(cxx_warnings "${cxx_warnings} -Wshadow")
set(cxx_warnings "${cxx_warnings} -Werror")
set(cxx_warnings "${cxx_warnings} -pedantic-errors")
set(cxx_warnings "${cxx_warnings} -Weffc++ ")

# Additional warnings
set(cxx_warnings "${cxx_warnings} -Wcast-align")
set(cxx_warnings "${cxx_warnings} -Wdisabled-optimization")
set(cxx_warnings "${cxx_warnings} -Wfloat-equal")
set(cxx_warnings "${cxx_warnings} -Winline")
set(cxx_warnings "${cxx_warnings} -Winvalid-pch")
set(cxx_warnings "${cxx_warnings} -Wmissing-format-attribute")
set(cxx_warnings "${cxx_warnings} -Wmissing-include-dirs")
set(cxx_warnings "${cxx_warnings} -Wpacked")
set(cxx_warnings "${cxx_warnings} -Wredundant-decls")
set(cxx_warnings "${cxx_warnings} -Wswitch-default")
set(cxx_warnings "${cxx_warnings} -Wswitch-enum")
set(cxx_warnings "${cxx_warnings} -Wunreachable-code")
set(cxx_warnings "${cxx_warnings} -Wwrite-strings")

# Some very strict warnings, that will be nice to use, but require some hefty refactoring
# set(cxx_warnings "${cxx_warnings} -Wcast-qual")
# set(cxx_warnings "${cxx_warnings} -Wconversion")
# set(cxx_warnings "${cxx_warnings} -Wformat=2")
# set(cxx_warnings "${cxx_warnings} -Wpadded")
# set(cxx_warnings "${cxx_warnings} -Wstrict-overflow")
# set(cxx_warnings "${cxx_warnings} -fno-strict-aliasing")

# Temporary support for GCC 8.
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(cxx_warnings "${cxx_warnings} -Wno-format-overflow")
endif()

# Set the flags and warnings for the debug/release builds
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g3 -O0 ${cxx_warnings}")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2 ${cxx_warnings}")

if ("${NUMORIA_CURSES}" STREQUAL "browser")
    set(CMAKE_CXX_FLAGS_RELEASE "-O3")
    set(CMAKE_EXECUTABLE_SUFFIX ".min.js")
endif ()
