#!/bin/bash

# pwgrep: pgrep + pwdx
# Shows PID, USER, Working Directory, and COMMAND for processes matching a pattern.

if [ -z "$1" ]; then
    echo "Usage: $(basename "$0") <pattern>"
    exit 1
fi

pattern="$1"

# Get PIDs, excluding this script itself and the grep/pgrep process if possible
# We use pgrep -f to match the full command line
pids=$(pgrep -f "$pattern" | grep -v "$$")

if [ -z "$pids" ]; then
    echo "No matching processes found for pattern: $pattern"
    exit 0
fi

# Header
printf "%-7s %-10s %-40s %s\n" "PID" "USER" "WORK_DIR" "COMMAND"
printf "%s\n" "--------------------------------------------------------------------------------"

for pid in $pids; do
    # Get user, and full command line
    # ps -p $pid -o user=,args= --no-headers
    read -r user cmd <<< "$(ps -p "$pid" -o user=,args= --no-headers 2>/dev/null)"
    
    # If process exited between pgrep and ps
    [ -z "$user" ] && continue

    # Get Working Directory
    # Try /proc/$pid/cwd first (Linux specific, very reliable if permissions allow)
    if [ -L "/proc/$pid/cwd" ]; then
        cwd=$(readlink "/proc/$pid/cwd" 2>/dev/null)
    fi
    
    # Fallback to pwdx if /proc failed or wasn't used
    if [ -z "$cwd" ]; then
        cwd=$(pwdx "$pid" 2>/dev/null | sed 's/^[0-9]*: //')
    fi
    
    [ -z "$cwd" ] && cwd="[Permission Denied]"

    printf "%-7s %-10s %-40s %s\n" "$pid" "$user" "$cwd" "$cmd"
done
