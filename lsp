#!/bin/bash

# Check if at least one port argument is provided
if [ -z "$1" ]; then
    echo "Usage: lsp <port> [port...]"
    exit 1
fi

FILTER=""
for PORT in "$@"; do
    if [ -n "$FILTER" ]; then
        FILTER="$FILTER or "
    fi
    FILTER="${FILTER}sport = :$PORT"
done

# List the processes listening on the specified ports
ss -ltnp "( $FILTER )"
