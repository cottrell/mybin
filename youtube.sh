#!/bin/bash
# pip install yt-dlp
if [ -z "$1" ]; then
    echo "Usage: youtube.sh <url>"
    exit 1
fi
yt-dlp -x --audio-format mp3 $1
