#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $(basename "$0") <org> [extra gh flags...]" >&2
    exit 1
fi

ORG="$1"
shift

if ! command -v gh >/dev/null 2>&1; then
    echo "Error: 'gh' CLI is required but not installed." >&2
    exit 1
fi

gh repo list "$ORG" --limit 1000 "$@" --json nameWithOwner -q '.[].nameWithOwner' | while read -r repo; do
    [ -n "$repo" ] && gh repo clone "$repo"
done
