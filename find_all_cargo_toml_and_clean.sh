#!/bin/bash
for x in $(find . -name 'Cargo.toml'); do
    b=$(dirname $x)
    echo $b
    cd $b
    cargo clean
    cd -
done
