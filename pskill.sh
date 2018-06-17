#!/bin/sh
# ps aux | grep blah_blah
# you want kill all you see?
# ps aux | grep blah_blah | pskill.sh
pids=$(awk '{print $2}')
read -p "Really kill PIDS $(echo $pids | tr '\n' ' ')? " -n 1 -r </dev/tty
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # do dangerous stuff
    echo kill -9 $pids
    kill -9 $pids
fi
