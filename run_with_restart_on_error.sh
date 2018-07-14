#!/bin/sh
trap "kill -- -$$" EXIT
echo "run_with_restart_on_error.sh $@ ... " >&2
until eval "$@"; do 
    echo "run_with_restart_on_error.sh $@ failed with exit code $?. Restarting ... " >&2
    sleep 1
done
