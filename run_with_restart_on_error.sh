#!/bin/sh
# TAG: keep running

# Set default sleep time (in seconds)
sleep_time=5

# Parse arguments
while getopts ":s:" opt; do
  case $opt in
    s) sleep_time="$OPTARG"
       ;;
    \?) echo "Invalid option: -$OPTARG" >&2
       exit 1
       ;;
  esac
done

# Shift arguments to avoid processing them as options
shift $(($OPTIND - 1))

# Main loop
trap "kill -- -$$" EXIT
echo "run_with_restart_on_error.sh $@ ... " >&2
until eval "$@"; do
  echo "$(date) run_with_restart_on_error.sh $@ failed with exit code $?. Sleeping for $sleep_time s then restarting ... " >&2
  sleep "$sleep_time"
done

# # TAG: keep running
# trap "kill -- -$$" EXIT
# echo "run_with_restart_on_error.sh $@ ... " >&2
# until eval "$@"; do
#     echo "$(date) run_with_restart_on_error.sh $@ failed with exit code $?. Restarting ... " >&2
#     sleep 1
# done


