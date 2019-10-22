#!/bin/bash -e
echo use arg attach to attach
host=$1
shift
ssh -t $host "tmux -CC $*"
