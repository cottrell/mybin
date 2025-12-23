#!/bin/bash

if ! [[ $1 ]]; then
    echo prog repo_name
    exit 1
fi
gh repo create $1 --source=. --private --push
