#!/bin/bash -e

if [[ $# -lt 2 ]]; then
    echo usage: prog host port port
    exit 1
fi

host=$1
for x in $*; do
    echo ssh -N -f -L localhost:$port:localhost:$port $host
    ssh -N -f -L localhost:$port:localhost:$port $host
done
