#!/usr/bin/env bash
# Rebuilds the combined branch by merging all patch branches onto upstream/master.
# Auto-resolves known add-add conflicts in config files using union strategy.
# Stops with an error if unexpected files conflict.
#
# Target branch defaults to 'dev'. Override with TARGET_BRANCH env var:
#   TARGET_BRANCH=master bash scripts/rebuild-combined.sh

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

UPSTREAM="upstream/master"
TARGET_BRANCH="${TARGET_BRANCH:-dev}"

# Ordered list of patch branches to merge
PATCHES=(
    patch/build-system
    patch/color-display
    patch/auto-haggle
    patch/lost-item-feedback
    patch/revocable-recall
    patch/wizard-summon
    patch/full-monster-recall
    patch/auto-open-doors
    patch/death-screen
    patch/numoria-docs
    patch/maintenance-scripts
)

# Files where add-add conflicts are expected and safely resolved with union.
# Conflicts here happen because every patch appends to the same insertion point.
KNOWN_CONFLICT_FILES=(
    src/config.cpp
    src/config.h
    src/game.cpp
    src/game_save.cpp
)

die() { echo "ERROR: $*" >&2; exit 1; }

git rev-parse --git-dir > /dev/null 2>&1 || die "Not inside a git repository"
git rev-parse "$UPSTREAM" > /dev/null 2>&1 || die "Remote ref '$UPSTREAM' not found"

for branch in "${PATCHES[@]}"; do
    git rev-parse "$branch" > /dev/null 2>&1 || die "Branch '$branch' not found"
done

if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
    die "Working tree is dirty. Commit or stash changes before running this script."
fi

echo "Recreating '$TARGET_BRANCH' from '$UPSTREAM'..."
git checkout -B "$TARGET_BRANCH" "$UPSTREAM"

resolve_union() {
    local file="$1"
    local tmp_base tmp_ours tmp_theirs
    tmp_base=$(mktemp)
    tmp_ours=$(mktemp)
    tmp_theirs=$(mktemp)

    git show ":1:$file" > "$tmp_base"   # merge base
    git show ":2:$file" > "$tmp_ours"   # HEAD (our version)
    git show ":3:$file" > "$tmp_theirs" # branch being merged

    # git merge-file --union writes into the first file; non-zero exit means
    # there are still unresolved conflicts (should not happen for union).
    if ! git merge-file --union "$tmp_ours" "$tmp_base" "$tmp_theirs"; then
        rm -f "$tmp_base" "$tmp_ours" "$tmp_theirs"
        die "Union merge still left conflicts in '$file' -- manual resolution needed"
    fi

    cp "$tmp_ours" "$file"
    rm -f "$tmp_base" "$tmp_ours" "$tmp_theirs"
    git add "$file"
}

for branch in "${PATCHES[@]}"; do
    echo ""
    echo "Merging $branch..."

    if git merge --no-edit "$branch"; then
        echo "  -> clean merge"
        continue
    fi

    # Merge failed -- check which files conflict
    mapfile -t conflicting < <(git diff --name-only --diff-filter=U)

    if [[ ${#conflicting[@]} -eq 0 ]]; then
        die "Merge of '$branch' failed but no conflicting files found -- unexpected state"
    fi

    # Verify every conflicting file is in the known list
    for file in "${conflicting[@]}"; do
        known=false
        for known_file in "${KNOWN_CONFLICT_FILES[@]}"; do
            if [[ "$file" == "$known_file" ]]; then
                known=true
                break
            fi
        done
        if [[ "$known" == false ]]; then
            git merge --abort
            die "Unexpected conflict in '$file' while merging '$branch'. Aborting - manual resolution required."
        fi
    done

    echo "  -> conflict in: ${conflicting[*]}"
    echo "     Applying union resolution..."

    for file in "${conflicting[@]}"; do
        resolve_union "$file"
        echo "     resolved: $file"
    done

    git commit --no-edit
    echo "  -> resolved and committed"
done

echo ""
echo "Done. '$TARGET_BRANCH' now contains all patches on top of '$UPSTREAM'."
git log --oneline "$(git rev-parse "$UPSTREAM")"..HEAD
