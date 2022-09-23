include (ExternalProject)

find_package(Git REQUIRED)
find_program(MAKE_EXE NAMES gmake make)

set(PDC_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/pdcurses)
set(PDC_INCLUDE_DIR ${PDC_PREFIX}/include)
set(PDC_LIBRARIES ${PDC_PREFIX}/lib/libpdcurses.a)
set(PDC_MAKE_OPTS WIDE=Y UTF8=Y)

if ("${PDC_PLATFORM}" STREQUAL "sdl2")
    set(PDC_BYPRODUCT libpdcurses.a)
    list(APPEND PDC_LIBRARIES  -lSDL2 -lSDL2_ttf)
elseif ("${PDC_PLATFORM}" STREQUAL "wingui")
    set(PDC_BYPRODUCT pdcurses.a)
    list(APPEND PDC_MAKE_OPTS  _w64=1)
    list(APPEND PDC_LIBRARIES  -lgdi32 -lcomdlg32 -lwinmm)
endif ()

ExternalProject_Add(
    pdcurses
    PREFIX ${PDC_PREFIX}
    GIT_REPOSITORY https://github.com/Bill-Gray/PDCursesMod.git
    GIT_TAG origin/master
    GIT_SHALLOW ON

    CONFIGURE_COMMAND ""

    BUILD_IN_SOURCE ON
    SOURCE_SUBDIR ${PDC_PLATFORM}

    LIST_SEPARATOR " "
    BUILD_COMMAND ${MAKE_EXE} ${PDC_MAKE_OPTS} libs
    BUILD_BYPRODUCTS <INSTALL_DIR>/lib/libpdcurses.a

    INSTALL_COMMAND
        ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/<SOURCE_SUBDIR>/${PDC_BYPRODUCT} <INSTALL_DIR>/lib/libpdcurses.a &&
        ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/curses.h <INSTALL_DIR>/include/pdcurses.h
)


set(CURSES_INCLUDE_DIR ${PDC_INCLUDE_DIR})
set(CURSES_LIBRARIES ${PDC_LIBRARIES})
