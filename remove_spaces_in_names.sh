#!/bin/bash
if [[ $# -lt 1 ]]; then
    echo usage prog files
    exit 1
fi

tmp=$(mktemp)
something=
for x in "$@"; do
    echo $x | grep -q ' ' || continue
    dest=$(echo $x | sed 's/ //g')
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
