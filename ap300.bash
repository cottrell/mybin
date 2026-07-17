#!/usr/bin/env bash
set -euo pipefail

R=(uvx ruff@latest)
LINE_LENGTH=300

"${R[@]}" check --select I --fix --line-length "$LINE_LENGTH" "$@"
"${R[@]}" format \
    --line-length "$LINE_LENGTH" \
    --config 'format.quote-style="preserve"' \
    "$@"
"${R[@]}" check --select E,F,I --line-length "$LINE_LENGTH" "$@"
