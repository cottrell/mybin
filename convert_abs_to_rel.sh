#!/bin/bash -e
if [[ $# -ne 1 ]]; then
    echo usage: prog dirname
    exit 1
fi
git reset --hard HEAD
absolute_to_relative_imports.py $1
git ch abs_to_rel
git commit -m 'abs_to_rel' -a
git push $(whoami) abs_to_rel:abs_to_rel -f
