#!/bin/bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <destination-directory>"
    exit 1
fi

DST="$1"

mkdir -pv "$DST"

git ls-files \
| tar --files-from=- -cvf - \
| (cd "$DST" && tar -xvf -)

