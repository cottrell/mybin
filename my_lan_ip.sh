#!/bin/bash
if [ $(uname) = 'Darwin' ]; then
    # ipconfig getifaddr en0
    /sbin/ifconfig | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
else
    # hostname -I | cut -d' ' -f1
    # hostname -I | sed -e 's/\s\+$//' | rev | cut -d' ' -f1 | rev
    /bin/hostname -I | /usr/bin/xargs -n 1 | grep 192 | /usr/bin/head -1
fi
