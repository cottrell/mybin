#!/bin/sh
while read line; do
    tr ' ' '\n' | grep -o '[a-zA-Z]*' | grep -v '^$' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -g
done < "${1:-/dev/stdin}"

