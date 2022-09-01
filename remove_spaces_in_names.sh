#!/bin/bash
set -e

if [[ $# -lt 1 ]]; then
    echo usage prog sep files
    exit 1
fi

function parse() {
    for arg in "$@"; do # transform long options to short ones
        shift
        case "$arg" in
            "--sep") set -- "$@" "-s" ;;
            "--verbose") set -- "$@" "-v" ;;
            *) set -- "$@" "$arg"
        esac
    done

    while getopts "s:v" optname  # left to ":" are flags that expect a value, right to the ":" are flags that expect nothing
    do
        case "$optname" in
            "s") sep=${OPTARG} ;;
            "v") verbose=true ;;
        esac
    done
    shift "$((OPTIND-1))" # shift out all the already processed options
}


parse "$@"

default_sep=
sep="${sep:-$default_sep}"

tmp=$(mktemp)
something=
for x in "$@"; do
    echo $x | grep -q ' ' || continue
    dest=$(echo $x | sed "s/ /$sep/g")
    echo mv \"$x\" \"$dest\" >> $tmp
    something="something"
done
if [[ "$something" = "" ]]; then
    exit
fi
cat $tmp
read -p "Run this? yN" yesno
if [[ "$yesno" == "y" ]]; then
    bash $tmp
    echo done
else
    echo not running
fi
rm $tmp
