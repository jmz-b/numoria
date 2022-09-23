# NUmoria CHANGELOG

Tracking all changes to upstream umoria


## Add auto-open doors option

- Option on by default, can be disabled in `=` menu

- Automatically attempt to open a door by moving into it


## Add full monster recall option

- Option on by default, can be disabled in `=` menu

- When enabled, players know everything about a monster when using
  `(r)ecall`

- If it is then disabled again, no knowledge revealed through it's use
  will persists in the players memory and will not be available in the
  current or any subsequent runs

- Feature implemented using `memoryWizardModeInit`, however this
  function was slightly modified so we can still keep track of the
  number of kills


## Add wizard command to summon a specific monster

- Add command to summon monster with an object ID

- ID is the monster's index in `creature_list[]`

- Command is bound to `)` in wizard mode


## Add revocable word-of-recall

- Reading a second word-of-recall before teleporting will cancel the
  first one, printing the message "A tension leaves the air around you"

Ported from Lars Helgeland's cancel-WoR patch for `v5.5.2`

Original patch found at: https://www.geocities.ws/lhelgeland/umoria.html


## Add lost item feedback messages

- Refactor `inventoryDestroyItem` so it is responsible for printing lost
  item messages

- If `inventoryDestroyItem` is called with a message string of non-zero
  length, print the message as well as a description of the item that
  was destroyed

- Losing an item due to elemental damage or theft now produces a message
  like this:

  There is smoke coming from your pack!
  You lost a Scroll titled "hyd yp"

Ported from Lars Helgeland's lost-item-feedback patch for `v5.5.2`

Original patch found at: https://www.geocities.ws/lhelgeland/umoria.html


## Add auto-haggle option

- Automatically agree on a price at the cost of a 10 percent tax on the
  final price of items you would otherwise have had to haggle for

- All prices displayed in the stores will be the actual prices you have
  to pay

- Option on by default, can be disabled in `=` menu

Ported Lars Helgeland's auto-haggle patch for `v5.5.2`

Original patch found at: https://www.geocities.ws/lhelgeland/umoria.html


## Add color display option

- Colorize many items, monsters, dungeon features and menu entries

- Adds Fire, lightning, and glowing effects

- Heavily based on github.com/andrewtweber/umoria-color however
  reimplemented to better fit the style of the rest
  of the code base:
  - Use standard types as suggested in `CONTRIBUTING.md`
  - Use `constexpr` rather than `#define` for constants

- Add solid walls using curses background colors
  - Define an additional color pair for all colors using `Color_Wall` as
    bg color
  - Use them to display walls, seams, treasure in walls and hidden doors

- Options are on by default, can be disabled in `=` menu


## Rewrite CMake build system

- Split `CMakeLists.txt` into multiple files with (hopefully) logical
  distinctions

- Add support for more Curses implementations, configurable with
  `NUMORIA_CURSES` cmake variable. Currently supported options are:
  `ncurses`, `sdl2` and `wingui`

- Setting `NUMORIA_CURSES` to any other value (eg. `curses`) will try
  and use whatever Curses implementation is available on the system

- Add `PDCursesMod.cmake`. This provides the `sdl2` and `wingui` Curses
  implementations. It uses ExternalProject to download and build the
  libraries at build time

- Add `mingw-w64-x86_64.cmake` toolchain for cross-compiling windows
  executables from linux. Credits to
  https://gist.github.com/ebraminio/2e32c8f6d032a8e01606f7f564d2b1ee

- Remove parsing of release date from `CHANGELOG.md`, just use the
  current UTC date instead

- Remove parsing of version number from `version.h`, instead move
  `src/version.h` to `data/version.h.in` and use `configure_file()` to
  generate it from CMake's `PROJECT_VERSION` variables

- Remove all Microsoft Visual Studio compiler related stuff, since I
  have no way of testing it

- Update `src/curses.h` to support the above changes

- Change executable name and splash screen banner to "numoria"


