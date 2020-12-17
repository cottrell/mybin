#!/bin/sh
if [ $(uname) = 'Darwin' ]; then
    # ipconfig getifaddr en0
    ifconfig | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
else
    # hostname -I | cut -d' ' -f1
    hostname -I | sed -e 's/\s\+$//' | rev | cut -d' ' -f1 | rev
fi
