#!/bin/sh
remote="origin"
old=$(git config --get remote.origin.url)
echo "OLD $remote: $old"
if $(echo $old | grep -q '^git@'); then
    echo nothing to change
else
    new=$(echo $old | sed -e 's|https://github.com/|git@github.com:|')
    cmd="git remote set-url $remote $new"
    echo
    echo WILL RUN:
    echo $cmd
    echo
    echo sleeping for 3 for you to check
    sleep 3

    $cmd
    git remote show $remote
fi
