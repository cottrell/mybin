#!/bin/bash

# Script to update _sidebar.md with all .md files in the directory
# Usage: ./update_sidebar.sh [directory]
# If no directory is provided, uses current directory

# Set target directory (use argument if provided, otherwise current directory)
TARGET_DIR="${1:-.}"

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist"
    exit 1
fi

SIDEBAR_FILE="$TARGET_DIR/_sidebar.md"

# Create _sidebar.md if it doesn't exist
if [ ! -f "$SIDEBAR_FILE" ]; then
    echo "Creating new _sidebar.md"
    touch "$SIDEBAR_FILE"
fi

# Get all .md files excluding _sidebar.md
MD_FILES=$(find "$TARGET_DIR" -maxdepth 1 -name "*.md" -not -name "_sidebar.md" | sort)

# Process each .md file
for md_file in $MD_FILES; do
    # Get just the filename without path
    filename=$(basename "$md_file")
    
    # Check if this file is already referenced in _sidebar.md
    # Look for the pattern ]($filename) in the sidebar
    if ! grep -q "](${filename})" "$SIDEBAR_FILE" 2>/dev/null; then
        # Extract name without .md extension for the label
        name_without_ext="${filename%.md}"
        
        # Add entry to _sidebar.md
        echo "* [$name_without_ext]($filename)" >> "$SIDEBAR_FILE"
        echo "Added: $filename"
    fi
done

echo "Sidebar update complete"