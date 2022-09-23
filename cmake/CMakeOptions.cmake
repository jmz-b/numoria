set(NUMORIA_CURSES "ncurses" CACHE STRING "Select Curses implementation: ncurses, sdl2, wingui")
set(NUMORIA_PDC_PLATFORMS CACHE INTERNAL "sdl2" "wingui")
message(STATUS "Using ${NUMORIA_CURSES} Curses implementation")
