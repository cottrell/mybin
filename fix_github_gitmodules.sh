#!/bin/bash

for x in $(find . -name .gitmodules); do
    cmd="sed -i -e 's|https://github.com/|git@github.com:|' $x"
    echo $cmd
    sed -i -e 's|https://github.com/|git@github.com:|' $x
done
