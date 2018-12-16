#!/bin/sh
if [ $(uname) = 'Darwin' ]; then
    ipconfig getifaddr en1
else
    hostname -I | cut -d' ' -f1
fi
