#!/bin/bash

# Script to update _sidebar.md with all .md files in the directory
# Usage: ./update_sidebar.sh [-s SECTION]
#   -s SECTION  Optional: Add entries under a subsection (e.g., "Topics")

# Use current working directory
DIR="."
SIDEBAR_FILE="$DIR/_sidebar.md"
SECTION=""

# Parse arguments
while getopts "s:" opt; do
    case $opt in
        s) SECTION="$OPTARG" ;;
        *) echo "Usage: $0 [-s SECTION]"; exit 1 ;;
    esac
done

# Create _sidebar.md if it doesn't exist
if [ ! -f "$SIDEBAR_FILE" ]; then
    echo "Creating new _sidebar.md"
    if [ -n "$SECTION" ]; then
        echo "* $SECTION" > "$SIDEBAR_FILE"
    else
        touch "$SIDEBAR_FILE"
    fi
fi

# Ensure sidebar is writable
if [ ! -w "$SIDEBAR_FILE" ]; then
    echo "Error: _sidebar.md is not writable"
    exit 1
fi

# Get all .md files excluding _sidebar.md, _navbar.md, and special files
MD_FILES=$(find "$DIR" -maxdepth 1 -name "*.md" -not -name "_sidebar.md" -not -name "_navbar.md" -not -name "README.md" -not -name "TODO.md" | sort)

# Count files
ADDED=0
SKIPPED=0

echo "Scanning for .md files in $DIR..."

# Process each .md file
for md_file in $MD_FILES; do
    # Get just the filename without path
    filename=$(basename "$md_file")
    name_without_ext="${filename%.md}"

    # Title case: convert underscores to spaces and capitalize each word
    title_cased=$(echo "$name_without_ext" | tr '_' ' ' | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1))tolower(substr($i,2))}}1')

    # Build the link pattern to search for (no leading slash for subdir compatibility)
    LINK_SEARCH_PATTERN="]($name_without_ext)"

    # Check if this file is already referenced in _sidebar.md
    if ! grep -qF "$LINK_SEARCH_PATTERN" "$SIDEBAR_FILE" 2>/dev/null; then
        if [ -n "$SECTION" ]; then
            # Indented entry under section
            LINK="  * [$title_cased]($name_without_ext)"
            # Insert after section header
            sed -i "/^\* $SECTION$/a\\$LINK" "$SIDEBAR_FILE"
        else
            # Top-level entry - append to end of file
            LINK="* [$title_cased]($name_without_ext)"
            echo "$LINK" >> "$SIDEBAR_FILE"
        fi
        if [ $? -ne 0 ]; then
            echo "Error: Failed to update _sidebar.md"
            exit 1
        fi
        echo "  + Added: $title_cased -> $name_without_ext"
        ((ADDED++))
    else
        echo "  - Skipped (exists): $filename -> $name_without_ext"
        ((SKIPPED++))
    fi
done

echo ""
echo "Sidebar update complete: $ADDED added, $SKIPPED skipped"