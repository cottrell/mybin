#!/bin/bash
# uv pip install yt-dlp
echo "consider updating:"
echo "uv pip install --upgrade yt-dlp"
if [ -z "$1" ]; then
    echo "Usage: youtube.sh <url>"
    exit 1
fi
yt-dlp --js-runtimes node --remote-components ejs:github -x --audio-format mp3 $1
