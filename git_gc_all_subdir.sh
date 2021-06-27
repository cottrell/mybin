#!/bin/bash -e

# run in current directoy recursively

curdir=$(pwd)

for x in $(find . -name '.git'); do
    base=$(realpath $curdir/$(dirname $x))
    if [[ -d $base ]]; then
        cmd="cd $base && git gc --aggressive"
        echo $cmd
        eval $cmd
    else
        echo "INFO: directory <$base> went missing while running."
    fi
done
