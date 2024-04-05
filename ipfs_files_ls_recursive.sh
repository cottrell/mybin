#!/bin/bash

function list_directory_recursive() {
    local path="$1"
    ipfs files ls "$path" | while read -r name; do
        local full_path="${path%/}/$name"
        echo "$full_path"
        if ipfs files stat --format="<type>" "$full_path" 2>/dev/null | grep -q directory; then
            list_directory_recursive "$full_path"
        fi
    done
}

path="${1:-/}"
list_directory_recursive $path
