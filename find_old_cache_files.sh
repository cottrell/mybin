#!/bin/bash
cmd="find $HOME/.cache -type d -ctime +$((365 / 2))"
eval $cmd
echo
echo DO THIS TO REMOVE
echo "$cmd -exec rm -rf {} \;"
