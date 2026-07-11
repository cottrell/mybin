#!/bin/bash
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
elif [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

export PATH="$HOME/.bun/bin:$HOME/.local/bin:$HOME/bin:$PATH"

bash -c "$@"
