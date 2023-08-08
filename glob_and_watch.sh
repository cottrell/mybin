#!/bin/bash
cleanup() {
    echo "Cleaning up..."
    kill $pid1 $pid2 2>/dev/null
}

trap cleanup INT TERM EXIT

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd $DIR
TARGET=./raw

function doglob() {
    echo "ts,path,events"
    cd $DIR
    find $TARGET -type f | while read -r file; do
        timestamp=$(stat -c "%y" "$file" | cut -d' ' -f1,2)
        echo "$timestamp,$file,glob"
    done
}

function dowatch() {
    echo "ts,path,events"
    inotifywait -mrq --timefmt '%Y-%m-%dT%H:%M:%S' --format '%T,%w%f,%|e' \
    -e attrib \
    -e close_write \
    -e moved_to \
    -e moved_from \
    -e move_self \
    -e create \
    -e delete \
    -e delete_self \
    -e unmount \
    $TARGET
}

doglob > glob.csv 2> glob.err &
pid1=$!

dowatch > watch.csv 2> watch.err &
pid2=$!

wait $pid1
wait $pid2

trap - INT TERM EXIT

echo $pid1
echo $pid2
echo should be stopped
