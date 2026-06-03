#!/usr/bin/env bash
# Builds every patch branch and dev, reports pass/fail for each.
# Branches using the cmake rewrite are built with ncurses, pdc/sdl2, and pdc/gl.
# patch/emscripten and dev are also built with emcmake if emcc is available.
# Others (based on upstream cmake) are built with ncurses only.
#
# Build artifacts go in /tmp/numoria-builds/<branch>-<label> and are
# reused across runs (cmake is incremental). Pass --clean to wipe them first.
#
# Requires: cmake, libncurses-dev, libsdl2-dev, libsdl2-ttf-dev, libgl-dev

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

BUILD_BASE="/tmp/numoria-builds"
CLEAN=false

if [[ "${1:-}" == "--clean" ]]; then
    CLEAN=true
fi

BRANCHES=(
    patch/build-system
    patch/color-display
    patch/emscripten
    patch/auto-haggle
    patch/lost-item-feedback
    patch/revocable-recall
    patch/wizard-summon
    patch/full-monster-recall
    patch/auto-open-doors
    patch/death-screen
    patch/numoria-docs
    patch/maintenance-scripts
    dev
)

SAVED_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
restore_branch() { git checkout "$SAVED_BRANCH" 2>/dev/null || true; }
trap restore_branch EXIT

die() { echo "ERROR: $*" >&2; exit 1; }

which cmake > /dev/null 2>&1 || die "cmake not found"
which g++ > /dev/null 2>&1   || die "g++ not found"

EMCC="$(which emcc 2>/dev/null || true)"

PASS=()
FAIL=()

build_native() {
    local branch="$1" label="$2" && shift 2
    local cmake_args=("$@")
    local slug="${branch//\//-}-${label//\//-}"
    local build_dir="$BUILD_BASE/$slug"
    local log="$build_dir/build.log"

    if [[ "$CLEAN" == true && -d "$build_dir" ]]; then
        rm -rf "$build_dir"
    fi
    mkdir -p "$build_dir"

    printf "  %-12s ... " "$label"

    if cmake -B "$build_dir" -DCMAKE_BUILD_TYPE=Release "${cmake_args[@]}" > "$log" 2>&1 \
        && cmake --build "$build_dir" --parallel >> "$log" 2>&1; then
        echo "PASS"
        PASS+=("$branch ($label)")
    else
        echo "FAIL  (see $log)"
        FAIL+=("$branch ($label)")
    fi
}

build_emscripten() {
    local branch="$1"
    local slug="${branch//\//-}-emscripten"
    local build_dir="$BUILD_BASE/$slug"
    local log="$build_dir/build.log"

    if [[ "$CLEAN" == true && -d "$build_dir" ]]; then
        rm -rf "$build_dir"
    fi
    mkdir -p "$build_dir"

    printf "  %-12s ... " "emscripten"

    if emcmake cmake -B "$build_dir" -DCMAKE_BUILD_TYPE=Release > "$log" 2>&1 \
        && cmake --build "$build_dir" --parallel >> "$log" 2>&1; then
        echo "PASS"
        PASS+=("$branch (emscripten)")
    else
        echo "FAIL  (see $log)"
        FAIL+=("$branch (emscripten)")
    fi
}

for branch in "${BRANCHES[@]}"; do
    if ! git rev-parse "$branch" > /dev/null 2>&1; then
        echo "SKIP $branch (branch not found)"
        continue
    fi

    echo "$branch"
    git checkout --quiet "$branch"

    if [[ "$branch" == "patch/emscripten" ]]; then
        if [[ -n "$EMCC" ]]; then
            build_emscripten "$branch"
        else
            echo "  emscripten   SKIP (emcc not in PATH)"
        fi
    elif [[ -f "cmake/CMakeOptions.cmake" ]]; then
        build_native "$branch" ncurses  -DNUMORIA_BACKEND=ncurses
        build_native "$branch" pdc/sdl2 -DNUMORIA_BACKEND=pdc -DPDC_PORT=sdl2
        build_native "$branch" pdc/gl   -DNUMORIA_BACKEND=pdc -DPDC_PORT=gl
        if [[ "$branch" == "dev" ]] && [[ -n "$EMCC" ]]; then
            build_emscripten "$branch"
        fi
    else
        build_native "$branch" ncurses
    fi
done

echo ""
echo "Results: ${#PASS[@]} passed, ${#FAIL[@]} failed"
if [[ ${#FAIL[@]} -gt 0 ]]; then
    echo "Failed:"
    for b in "${FAIL[@]}"; do echo "  $b"; done
    exit 1
fi
