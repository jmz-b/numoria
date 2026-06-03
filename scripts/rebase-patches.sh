#!/usr/bin/env bash
# Rebases all patch branches onto the latest upstream/master.
# Run after `git fetch upstream`, or use scripts/update.sh which does both.
#
# Dependency graph:
#   upstream/master -> patch/build-system -> patch/color-display
#                                         -> patch/emscripten
#   upstream/master -> all other patches (standalone)

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

UPSTREAM="upstream/master"

# build-system must come first; color-display is rebased onto it afterward
STANDALONE_PATCHES=(
    patch/build-system
    patch/auto-haggle
    patch/lost-item-feedback
    patch/revocable-recall
    patch/wizard-summon
    patch/full-monster-recall
    patch/auto-open-doors
    patch/numoria-docs
)

die() { echo "ERROR: $*" >&2; exit 1; }

git rev-parse --git-dir > /dev/null 2>&1 || die "Not inside a git repository"
git rev-parse "$UPSTREAM" > /dev/null 2>&1 \
    || die "Remote ref '$UPSTREAM' not found. Run 'git fetch upstream' first."

if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
    die "Working tree is dirty. Commit or stash changes first."
fi

SAVED_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
restore_branch() { git checkout "$SAVED_BRANCH" 2>/dev/null || true; }
trap restore_branch EXIT

for branch in "${STANDALONE_PATCHES[@]}"; do
    git rev-parse "$branch" > /dev/null 2>&1 || { echo "SKIP: $branch (not found)"; continue; }
    echo "Rebasing $branch onto $UPSTREAM..."
    if ! git rebase "$UPSTREAM" "$branch"; then
        echo ""
        echo "CONFLICT during rebase of '$branch'."
        echo "Resolve conflicts, run 'git rebase --continue', then re-run this script."
        exit 1
    fi
    echo "  -> ok"
done

for branch in patch/color-display patch/emscripten; do
    git rev-parse "$branch" > /dev/null 2>&1 || { echo "SKIP: $branch (not found)"; continue; }
    echo "Rebasing $branch onto patch/build-system..."
    if ! git rebase patch/build-system "$branch"; then
        echo ""
        echo "CONFLICT during rebase of '$branch'."
        echo "Resolve conflicts, run 'git rebase --continue', then re-run this script."
        exit 1
    fi
    echo "  -> ok"
done

echo ""
echo "All patch branches rebased successfully onto $UPSTREAM."
echo "Next: run scripts/rebuild-combined.sh to update master."
