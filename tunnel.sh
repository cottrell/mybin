#!/bin/bash -e

if [[ $# -lt 2 ]]; then
    echo usage: prog host port port ...
    exit 1
fi

host=$1
shift
for port in $*; do
    echo ssh -v -N -f -L localhost:$port:localhost:$port $host
    ssh -v -N -f -L localhost:$port:localhost:$port $host
done
