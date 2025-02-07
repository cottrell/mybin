#!/bin/bash

# Normalize filenames in the current directory
for file in *; do
    # Skip if not a regular file
    [ -f "$file" ] || continue

    # Convert to lowercase, replace spaces with underscores, remove ampersands, replace commas with dashes
    newname=$(echo "$file" | tr '[:upper:]' '[:lower:]' | sed -E 's/[[:space:]]+/_/g; s/&/and/g; s/,/-/g; s/\+/_/g')

    # Remove special characters except dots, dashes, and underscores
    newname=$(echo "$newname" | sed 's/[^a-z0-9._-]//g')

    # Avoid overwriting existing files
    if [ "$file" != "$newname" ]; then
        if [ -e "$newname" ]; then
            echo "Skipping: $newname already exists."
        else
            mv "$file" "$newname"
            echo "Renamed: $file -> $newname"
        fi
    fi
done

