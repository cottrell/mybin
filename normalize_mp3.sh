#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Install it with: sudo apt install ffmpeg"
    exit 1
fi

# Check if at least one file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 file1.mp3 file2.mp3 ..."
    exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p normalized

# Normalize each MP3 file provided as an argument
for file in "$@"; do
    if [[ -f "$file" ]]; then
        output="normalized/${file##*/}"
        echo "Normalizing: $file -> $output"
        ffmpeg -i "$file" -af loudnorm -y "$output"
    else
        echo "Skipping: $file (not found)"
    fi
done

echo "Normalization complete. Files saved in 'normalized/' directory."

