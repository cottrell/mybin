#!/bin/bash

# Normalize filenames/directories to lowercase, replacing spaces/special characters.

RECURSIVE=false
TARGET_DIR="."

while [[ $# -gt 0 ]]; do
    case "$1" in
        -r|--recursive)
            RECURSIVE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [-r|--recursive] [directory]"
            echo "Normalizes filenames/directories to lowercase, replacing spaces/special characters."
            exit 0
            ;;
        -*)
            echo "Unknown option: $1"
            echo "Usage: $0 [-r|--recursive] [directory]"
            exit 1
            ;;
        *)
            if [ -d "$1" ]; then
                TARGET_DIR="$1"
                shift
            else
                echo "Invalid directory: $1"
                exit 1
            fi
            ;;
    esac
done

# Strip trailing slash from TARGET_DIR unless it's exactly "/"
if [ "$TARGET_DIR" != "/" ]; then
    TARGET_DIR="${TARGET_DIR%/}"
fi

normalize_item() {
    local file="$1"
    [ -e "$file" ] || return

    local dir
    dir=$(dirname "$file")
    local base
    base=$(basename "$file")

    # Convert to lowercase, replace spaces/pluses with underscores, remove ampersands, replace commas with dashes
    local newbase
    newbase=$(echo "$base" | tr '[:upper:]' '[:lower:]' | sed -E 's/[[:space:]]+/_/g; s/&/and/g; s/,/-/g; s/\+/_/g')

    # Remove special characters except dots, dashes, and underscores
    local newname
    newname=$(echo "$newbase" | sed 's/[^a-z0-9._-]//g')

    if [ -z "$newname" ]; then
        echo "Skipping: Normalized name for '$file' is empty."
        return
    fi

    # Avoid overwriting existing files
    if [ "$base" != "$newname" ]; then
        local newpath="$dir/$newname"
        if [ -e "$newpath" ]; then
            echo "Skipping: $newpath already exists."
        else
            mv "$file" "$newpath"
            echo "Renamed: $file -> $newpath"
        fi
    fi
}

# Normalize filenames in the target directory
if [ "$RECURSIVE" = true ]; then
    # Depth-first search to handle nested items bottom-up
    # -print0 and read -d '' to handle spaces/newlines in filenames
    find "$TARGET_DIR" -depth -mindepth 1 -print0 2>/dev/null | while IFS= read -r -d '' file; do
        # Extract path parts relative to TARGET_DIR
        local_path="${file#$TARGET_DIR}"
        local_path="${local_path#/}"
        
        # Skip hidden files/directories
        if [[ "$local_path" == .* || "$local_path" == */.* ]]; then
            continue
        fi

        normalize_item "$file"
    done
else
    # Non-recursive normalization of target directory
    for file in "$TARGET_DIR"/*; do
        [ -e "$file" ] || continue

        local_path="${file#$TARGET_DIR}"
        local_path="${local_path#/}"

        # Skip hidden files/directories
        if [[ "$local_path" == .* || "$local_path" == */.* ]]; then
            continue
        fi

        normalize_item "$file"
    done
fi
