#!/bin/bash -e
echo use arg attach to attach
ssh $1 -A -X -t "tmux -CC $2"
