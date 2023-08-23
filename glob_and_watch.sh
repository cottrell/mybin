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
    echo "ts,bytes,path,events"
    cd $DIR
    find $TARGET -type f | while read -r file; do
        ts_and_bytes=$(stat -c "%y,%s" "$file")
        echo "$ts_and_bytes,$file,glob"
    done
}

function dowatch() {
    echo "ts,bytes,path,events"
    # WARNING: might need "%w%f" to protect spaces
    inotifywait -mrq --timefmt '%Y-%m-%dT%H:%M:%S' --format '%T %w%f %|e' -e close_write,moved_to,moved_from,move_self,create,delete,delete_self,unmount $TARGET | \
    while read -r ts path events; do
        bytes=$(stat -c "%s" $path)
        echo "$ts,$bytes,$path,$events"
    done

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
