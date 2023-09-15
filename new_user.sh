#!/bin/bash
N=${1:-"3"}
shuf -n $N /usr/share/dict/british-english \
    | tr '[:upper:]' '[:lower:]' \
    | sed 's/[^a-zA-Z0-9 ]//g' \
    | sed 's/^\w/\u&/' \
    | tr -d '\n'
echo
