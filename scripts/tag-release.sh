#!/usr/bin/env bash
# Rebuilds master from dev, creates a release tag, and pushes both,
# triggering the release CI workflow. Run from the dev branch.
#
# Usage: scripts/tag-release.sh [--dry-run]

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
fi

die() { echo "ERROR: $*" >&2; exit 1; }

git rev-parse --git-dir > /dev/null 2>&1 || die "Not inside a git repository"
git rev-parse upstream/master > /dev/null 2>&1 \
    || die "upstream/master not found -- run 'git fetch upstream' first"

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$CURRENT_BRANCH" != "dev" ]]; then
    die "Must be on 'dev' to create a release tag (currently on '$CURRENT_BRANCH')"
fi

if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
    die "Working tree is dirty -- commit or stash changes first"
fi

# Read NUMORIA_REVISION from CMakeLists.txt
NUMORIA_REVISION="$(grep -Po '(?<=set\(NUMORIA_REVISION )\d+' CMakeLists.txt)"
[[ -n "$NUMORIA_REVISION" ]] || die "Could not read NUMORIA_REVISION from CMakeLists.txt"

# Get upstream version via git describe
UPSTREAM_DESCRIBE="$(git describe --tags upstream/master)"

TAG="${UPSTREAM_DESCRIBE}+${NUMORIA_REVISION}"

echo "Upstream: $UPSTREAM_DESCRIBE"
echo "Revision: $NUMORIA_REVISION"
echo "Tag:      $TAG"

if git rev-parse "$TAG" > /dev/null 2>&1; then
    die "Tag '$TAG' already exists"
fi

if [[ "$DRY_RUN" == true ]]; then
    echo ""
    echo "Dry run -- no tag created. Remove --dry-run to proceed."
    exit 0
fi

echo ""

# Create a release commit on master that uses dev's tree but keeps the
# previous master as its first parent, preserving linear release history.
# dev is the second parent so the provenance is visible in git log --graph.
DEV_HEAD="$(git rev-parse dev)"
DEV_TREE="$(git rev-parse dev^{tree})"
MASTER_HEAD="$(git rev-parse master 2>/dev/null || echo "")"

if [[ -n "$MASTER_HEAD" ]]; then
    NEW_COMMIT="$(git commit-tree "$DEV_TREE" -p "$MASTER_HEAD" -p "$DEV_HEAD" -m "Release $TAG")"
else
    NEW_COMMIT="$(git commit-tree "$DEV_TREE" -p "$DEV_HEAD" -m "Release $TAG")"
fi

git update-ref refs/heads/master "$NEW_COMMIT"
echo "Created release commit on master"

git tag "$TAG" master
echo "Created tag '$TAG' on master"

git push --force-with-lease origin master
git push origin "$TAG"
echo "Pushed master and tag '$TAG' -- release CI is now running"
