#!/bin/bash

# Script to update _sidebar.md with all .md files in the directory
# Usage: ./update_sidebar.sh

# Use current working directory
DIR="."

SIDEBAR_FILE="$DIR/_sidebar.md"

# Create _sidebar.md if it doesn't exist
if [ ! -f "$SIDEBAR_FILE" ]; then
    echo "Creating new _sidebar.md"
    echo "* Topics" > "$SIDEBAR_FILE"
fi

# Ensure sidebar is writable
if [ ! -w "$SIDEBAR_FILE" ]; then
    echo "Error: _sidebar.md is not writable"
    exit 1
fi

# Get all .md files excluding _sidebar.md, _navbar.md, and special files
MD_FILES=$(find "$DIR" -maxdepth 1 -name "*.md" -not -name "_sidebar.md" -not -name "_navbar.md" -not -name "README.md" -not -name "TODO.md" | sort)

# Process each .md file
for md_file in $MD_FILES; do
    # Get just the filename without path
    filename=$(basename "$md_file")
    name_without_ext="${filename%.md}"

    # Title case: convert underscores to spaces and capitalize each word
    title_cased=$(echo "$name_without_ext" | tr '_' ' ' | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1))tolower(substr($i,2))}}1')

    # Build the link pattern to search for
    LINK_SEARCH_PATTERN="](/$name_without_ext)"

    # Check if this file is already referenced in _sidebar.md
    if ! grep -qF "$LINK_SEARCH_PATTERN" "$SIDEBAR_FILE" 2>/dev/null; then
        # Build the link entry (indented like the note script)
        LINK="  * [$title_cased](/$name_without_ext)"

        # Insert after "* Topics" line
        sed -i "/^\* Topics$/a\\$LINK" "$SIDEBAR_FILE"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to update _sidebar.md"
            exit 1
        fi
        echo "Added: $title_cased -> /$name_without_ext"
    fi
done

echo "Sidebar update complete"