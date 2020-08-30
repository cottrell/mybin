#!/bin/bash
# https://gist.github.com/nucliweb/920aa39c250bde7facf7
if [[ "$#" -ne 1 ]]; then
    echo usage: $0 org
    exit 1
fi
curl -s https://api.github.com/users/$1/repos | grep -e 'clone_url*' | cut -d \" -f 4 | xargs -L1 git clone

