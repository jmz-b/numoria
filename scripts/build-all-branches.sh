#!/usr/bin/env bash
# Builds every patch branch and master, reports pass/fail for each.
# Branches using the cmake rewrite are built with ncurses, sdl2, and gl.
# Others (based on upstream cmake) are built with ncurses only.
#
# Build artifacts go in /tmp/numoria-builds/<branch>-<backend> and are
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
    patch/auto-haggle
    patch/lost-item-feedback
    patch/revocable-recall
    patch/wizard-summon
    patch/full-monster-recall
    patch/auto-open-doors
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

PASS=()
FAIL=()

build_one() {
    local branch="$1" backend="$2"
    local slug="${branch//\//-}-${backend}"
    local build_dir="$BUILD_BASE/$slug"
    local log="$build_dir/build.log"

    if [[ "$CLEAN" == true && -d "$build_dir" ]]; then
        rm -rf "$build_dir"
    fi
    mkdir -p "$build_dir"

    printf "  %-10s ... " "$backend"

    if cmake -B "$build_dir" -DCMAKE_BUILD_TYPE=Release -DNUMORIA_CURSES="$backend" > "$log" 2>&1 \
        && cmake --build "$build_dir" --parallel >> "$log" 2>&1; then
        echo "PASS"
        PASS+=("$branch ($backend)")
    else
        echo "FAIL  (see $log)"
        FAIL+=("$branch ($backend)")
    fi
}

for branch in "${BRANCHES[@]}"; do
    if ! git rev-parse "$branch" > /dev/null 2>&1; then
        echo "SKIP $branch (branch not found)"
        continue
    fi

    echo "$branch"
    git checkout --quiet "$branch"

    if [[ -f "cmake/CMakeOptions.cmake" ]]; then
        build_one "$branch" ncurses
        build_one "$branch" sdl2
        build_one "$branch" gl
    else
        build_one "$branch" ncurses
    fi
done

echo ""
echo "Results: ${#PASS[@]} passed, ${#FAIL[@]} failed"
if [[ ${#FAIL[@]} -gt 0 ]]; then
    echo "Failed:"
    for b in "${FAIL[@]}"; do echo "  $b"; done
    exit 1
fi
