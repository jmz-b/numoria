#!/usr/bin/env bash
# Full upstream sync: fetch -> rebase patches -> rebuild dev.
# On any conflict, stops and tells you exactly what to fix.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

SCRIPTS_DIR="$(dirname "$(realpath "$0")")"

die() { echo "ERROR: $*" >&2; exit 1; }

git rev-parse --git-dir > /dev/null 2>&1 || die "Not inside a git repository"
git remote get-url upstream > /dev/null 2>&1 || die "No 'upstream' remote configured."

if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
    die "Working tree is dirty. Commit or stash changes first."
fi

echo "Fetching upstream..."
git fetch upstream

NEW_TIP="$(git rev-parse upstream/dev)"
echo "upstream/dev is now at $NEW_TIP"

BASE="$(git merge-base dev upstream/dev 2>/dev/null || echo "")"
if [[ "$BASE" == "$NEW_TIP" ]]; then
    echo ""
    echo "Already up to date with upstream. Nothing to do."
    exit 0
fi

BEHIND="$(git rev-list upstream/dev..dev --count 2>/dev/null || echo "?")"
AHEAD="$(git rev-list dev..upstream/dev --count 2>/dev/null || echo "?")"
echo "dev is $BEHIND commits ahead, upstream has $AHEAD new commits."
echo ""

echo "=== Step 1/2: Rebase patch branches ==="
"$SCRIPTS_DIR/rebase-patches.sh"

echo ""
echo "=== Step 2/2: Rebuild dev ==="
"$SCRIPTS_DIR/rebuild-combined.sh"

echo ""
echo "Update complete. Review the result, then push:"
echo "  git push --force-with-lease origin 'refs/heads/patch/*' dev"
