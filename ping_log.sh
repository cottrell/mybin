#!/bin/bash
# ping $1 | sed 's/^.*time=\(.*\) ms$/\1/'
if [[ $# -ne 1 ]]; then
    echo usage: prog url
    exit 1
fi
start=$(date +%Y-%m-%dT%H:%M:%S)
f=$HOME/syncthing/logs/ping/$(hostname)/$1/$start.csv
echo will log to $f
mkdir -vp $(dirname $f)
ping $1 | while read pong; do echo "$(date +%Y-%m-%dT%H:%M:%S),$(echo $pong | sed 's/^.*time=\(.*\) ms$/\1/')"; done > $f
