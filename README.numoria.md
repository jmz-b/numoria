# NUmoria

_NUmoria_ is a fork of [Umoria](https://github.com/dungeons-of-moria/umoria)
based on the `v5.7.X` restoration release.

It aims to make playing classic Moria a more pleasant experience and more
accessable to new players by:

- Giving the player the option to remove some of the more tedious elements
  from the base game.
- Implementing quality of life features.
- Implementing user interface improvements.

## Notable changes (options can be enabled/disabled in `=` menu)

- Color display option
  - Colorize many items, monsters, dungeon features and menu entries.
  - Adds Fire, lightning, and glowing effects.
  - Add solid walls option.

- Auto-haggle option
  - Automatically agree on a price at the cost of a 10 percent tax on the
    final price of items you would otherwise have had to haggle for.
  - All prices displayed in the stores will be the actual prices you have
    to pay.

- Auto open doors option
  - Automatically attempt to open a door by moving into it.

- Full monster recall option
  - When enabled, players know everything about a monster when using
    `(r)ecall`.

- Lost item feedback messages
  - Losing an item due to elemental damage or theft now produces a message
    detail what was lost.

- Revocable word-of-recall
  - Reading a second word-of-recall before teleporting will cancel the
    first one.


Some features have been ported from old patches and Moria variants that are
based on Umoria `v5.5.X` or below and therefore apply to the old C codebase.
These patches have been rewritten to apply to restoration project release C++
codebase. Please see the `AUTHORS.numoria` file for full credits.

See `CHANGELOG.numoria.md` for a more complete list of changes.

## Compiling NUmoria

NUmoria offers are variety of Curses frontend builds.

  - `ncurses`: Console frontend
  - `sdl2`: SDL2 Window frontend
  - `wingui`: Win32 Graphics mode

Building has only been tested on Linux. Windows binaries are cross-compiled
using `mingw-w64`. Builds have not been tested on MacOS.

### Compiling with ncurses

- Install build dependencies, eg:

```sh
apt install cmake libncurses-dev
```

- Build:

```sh
cmake -DNUMORIA_CURSES=ncurses -B 'build/numoria-ncurses/' -S .
cmake --build 'build/numoria-ncurses/'
```

- Package tarball:

```sh
cmake --build 'build/numoria-ncurses/' --target package
```

### Compling with sdl2

- Install build dependencies, eg:

```sh
apt install git cmake libsdl2-dev libsdl2-ttf-dev
```

- Build:

```sh
cmake -DNUMORIA_CURSES=sdl2 -B 'build/numoria-sdl2/' -S .
cmake --build 'build/numoria-sdl2/'
```

- Package tarball:

```sh
cmake --build 'build/numoria-sdl2/' --target package
```

### Cross-compiling with wingui

- Install build dependencies, eg:

```sh
apt install git cmake mingw-w64
```

- Build:

```sh
cmake -DNUMORIA_CURSES=wingui -DCMAKE_TOOLCHAIN_FILE=cmake/Toolchains/mingw-w64-x86_64.cmake -B 'build/numoria-wingui/' -S .
cmake --build 'build/numoria-wingui/'
```

- Package zip:

```sh
cmake --build 'build/numoria-wingui/' --target package
```

## Notes

- You can also use `Ninja` as a build system. Pass `-G Ninja` to the `cmake`
  generate command.

- `README.md` is the original README from upstream. It is included as
  it contains some useful information, however the build instructions are
  obsolete.
