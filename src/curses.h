// Copyright (c) 1981-86 Robert A. Koeneke
// Copyright (c) 1987-94 James E. Wilson
//
// SPDX-License-Identifier: GPL-3.0-or-later

// Sets up curses for the correct system.

// clang-format off

#ifdef _WIN32
  // These are defined in Windows and also in ncurses/pdcurses
  #undef KEY_EVENT
  #undef MOUSE_MOVED
#endif

#ifdef NUMORIA_PDC
  #include <pdcurses.h>
#elif NUMORIA_NCURSES
  #include <ncurses.h>
#elif __EMSCRIPTEN__
  #include "browser_curses.h"
#else
  #include <curses.h>
#endif
