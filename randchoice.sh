#!/bin/sh
args=( "$@" )
echo "${args[RANDOM % ${#args[@]}]}"
