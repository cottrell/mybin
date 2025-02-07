#!/bin/bash

# Check if at least one argument is provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $(basename "$0") output_file input_dir_or_file..."
    exit 1
fi

# Extract output file and shift arguments
OUTPUT_FILE="$1"
shift

# assert output file does not exist
if [ -e "$OUTPUT_FILE" ]; then
    echo "Output file already exists! $OUTPUT_FILE"
    exit 1
fi

# Create the compressed archive

tar -cf - "$@" | xz -9 -T0 > "$OUTPUT_FILE"

# Verify success
if [ $? -eq 0 ]; then
    echo "Successfully created: $OUTPUT_FILE"
else
    echo "Compression failed"
    exit 1
fi
