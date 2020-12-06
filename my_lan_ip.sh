#!/bin/sh
if [ $(uname) = 'Darwin' ]; then
    ipconfig getifaddr en0
else
    # hostname -I | cut -d' ' -f1
    hostname -I | sed -e 's/\s\+$//' | rev | cut -d' ' -f1 | rev
fi
