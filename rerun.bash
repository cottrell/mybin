#!/usr/bin/env bash
# https://superuser.com/questions/181517/how-to-execute-a-command-whenever-a-file-changes

function execute() {
    clear
    echo "$@"
    eval "$@"
}

execute "$@"

inotifywait --quiet --recursive --monitor --event modify --format "%w%f" . \
| while read change; do
    execute "$@"
done
