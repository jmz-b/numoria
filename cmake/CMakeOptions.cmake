set(NUMORIA_BACKEND "ncurses" CACHE STRING "Display library: ncurses, pdc")
set(PDC_PORT "sdl2" CACHE STRING "PDCursesMod port (when NUMORIA_BACKEND=pdc): sdl2, gl, wingui")

if ("${NUMORIA_BACKEND}" STREQUAL "pdc")
    message(STATUS "Using pdc backend (${PDC_PORT} port)")
else ()
    message(STATUS "Using ${NUMORIA_BACKEND} backend")
endif ()
