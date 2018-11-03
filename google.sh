#!/bin/sh

if [ "$1" ]; then
    xidel http://www.google.de/search?q=$1 --extract "//a/extract(@href, 'url[?]q=([^&]+)&', 1)[. != '']"
else
    echo usage: prog search
fi
