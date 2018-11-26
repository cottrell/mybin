#!/bin/sh
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

if [ "$#" -ne 1 ]; then
    echo usage: prog email
    exit
fi

filename=~/.my_external_ip.txt
start=false
if [ ! -e "$filename" ]; then
    dig +short myip.opendns.com @resolver1.opendns.com > $filename
    start=true
fi
temp=$(mktemp)
dig +short myip.opendns.com @resolver1.opendns.com > $temp
if [ "$start" = true ] || [ "$(cat $filename)" != "$(cat $temp)" ]; then
    echo change detected
    echo "OLD: $(cat $filename)NEW: $(cat $temp)" | mail -s "New IP for bleepblop $(date)" $1
    cp -v $temp $filename
else
    echo no change
fi
rm -v $temp
