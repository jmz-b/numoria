cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

# Do not allow in-source builds
if (${CMAKE_SOURCE_DIR} STREQUAL "${PROJECT_SOURCE_DIR}/src")
    message(FATAL_ERROR "CMake generation is not allowed within the source directory!")
endif ()

# Set a default build type
set(default_build_type "Release")
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
else ()
    message(STATUS "Build type set to '${CMAKE_BUILD_TYPE}'")
endif ()

# Compiler settings (this must come before calling project)
set(CMAKE_CXX_STANDARD_REQUIRED on)
set(CMAKE_CXX_STANDARD 17)

project(numoria)

set(PROJECT_VERSION "v0.1.0")
set(PROJECT_VERSION_MAJOR "0")
set(PROJECT_VERSION_MINOR "1")
set(PROJECT_VERSION_PATCH "0")
set(upstream_version "v5.7.15")

string(TIMESTAMP current_date "%Y-%m-%d" UTC)

set(source_dir "${PROJECT_SOURCE_DIR}/src")
set(build_dir "numoria")
set(data_dir "${build_dir}/data")
set(EXECUTABLE_OUTPUT_PATH "${build_dir}")

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(
    source_files
    "${source_dir}/character.h"
    "${source_dir}/config.h"
    "${source_dir}/curses.h"
    "${source_dir}/dice.h"
    "${source_dir}/dungeon.h"
    "${source_dir}/dungeon_tile.h"
    "${source_dir}/game.h"
    "${source_dir}/headers.h"
    "${source_dir}/helpers.h"
    "${source_dir}/identification.h"
    "${source_dir}/inventory.h"
    "${source_dir}/mage_spells.h"
    "${source_dir}/monster.h"
    "${source_dir}/player.h"
    "${source_dir}/recall.h"
    "${source_dir}/rng.h"
    "${source_dir}/scores.h"
    "${source_dir}/scrolls.h"
    "${source_dir}/spells.h"
    "${source_dir}/staves.h"
    "${source_dir}/store.h"
    "${source_dir}/treasure.h"
    "${source_dir}/types.h"
    "${source_dir}/ui.h"
    "${source_dir}/wizard.h"
    "${source_dir}/config.cpp"
    "${source_dir}/helpers.cpp"
    "${source_dir}/rng.cpp"
    "${source_dir}/main.cpp"
    "${source_dir}/data_creatures.cpp"
    "${source_dir}/data_player.cpp"
    "${source_dir}/data_recall.cpp"
    "${source_dir}/data_store_owners.cpp"
    "${source_dir}/data_stores.cpp"
    "${source_dir}/data_tables.cpp"
    "${source_dir}/data_treasure.cpp"
    "${source_dir}/character.cpp"
    "${source_dir}/dice.cpp"
    "${source_dir}/dungeon.cpp"
    "${source_dir}/dungeon_generate.cpp"
    "${source_dir}/dungeon_los.cpp"
    "${source_dir}/game.cpp"
    "${source_dir}/game_death.cpp"
    "${source_dir}/game_files.cpp"
    "${source_dir}/game_objects.cpp"
    "${source_dir}/game_run.cpp"
    "${source_dir}/game_save.cpp"
    "${source_dir}/identification.cpp"
    "${source_dir}/inventory.cpp"
    "${source_dir}/mage_spells.cpp"
    "${source_dir}/monster.cpp"
    "${source_dir}/monster_manager.cpp"
    "${source_dir}/player.cpp"
    "${source_dir}/player_bash.cpp"
    "${source_dir}/player_eat.cpp"
    "${source_dir}/player_magic.cpp"
    "${source_dir}/player_move.cpp"
    "${source_dir}/player_pray.cpp"
    "${source_dir}/player_quaff.cpp"
    "${source_dir}/player_run.cpp"
    "${source_dir}/player_stats.cpp"
    "${source_dir}/player_throw.cpp"
    "${source_dir}/player_traps.cpp"
    "${source_dir}/player_tunnel.cpp"
    "${source_dir}/recall.cpp"
    "${source_dir}/scores.cpp"
    "${source_dir}/scrolls.cpp"
    "${source_dir}/spells.cpp"
    "${source_dir}/staves.cpp"
    "${source_dir}/store.cpp"
    "${source_dir}/store_inventory.cpp"
    "${source_dir}/treasure.cpp"
    "${source_dir}/ui.cpp"
    "${source_dir}/ui_inventory.cpp"
    "${source_dir}/ui_io.cpp"
    "${source_dir}/wizard.cpp"
)

configure_file("data/version.h.in" "${build_dir}/version.h")

# Core game data files
set(
    data_files
    "${PROJECT_SOURCE_DIR}/data/help.txt"
    "${PROJECT_SOURCE_DIR}/data/help_wizard.txt"
    "${PROJECT_SOURCE_DIR}/data/rl_help.txt"
    "${PROJECT_SOURCE_DIR}/data/rl_help_wizard.txt"
    "${PROJECT_SOURCE_DIR}/data/welcome.txt"
    "${PROJECT_SOURCE_DIR}/data/death_tomb.txt"
    "${PROJECT_SOURCE_DIR}/data/death_royal.txt"
)
file(COPY ${data_files} DESTINATION "${data_dir}")

# Various support files (readme, etc.)
set(
    support_files
    "${PROJECT_SOURCE_DIR}/data/scores.dat"
    "${PROJECT_SOURCE_DIR}/AUTHORS"
    "${PROJECT_SOURCE_DIR}/LICENSE"
    "${PROJECT_SOURCE_DIR}/README.md"
)
file(COPY ${support_files} DESTINATION "${build_dir}")

set(
    data_files_to_update
    "data/splash.txt"
    "data/versions.txt"
)
foreach (data_file ${data_files_to_update})
    configure_file("${data_file}.in" "${build_dir}/${data_file}")
endforeach ()

# All of the game resource files
set(resources ${data_files} ${support_files})

# Also add resources to the target so they are visible in the IDE
add_executable(numoria ${source_files} ${resources})

include(CMakeOptions)
include(CompilerFlags)
include(CompileDefinitions)
include(LibraryConfiguration)
include(InstallConfiguration)
include(PackConfiguration)

target_link_libraries(numoria ${linked_libs})
