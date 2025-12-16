#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <repository-name>"
    exit 1
fi

echo "Running: gh repo create $1 --source=. --private --push"
gh repo create $1 --source=. --private --push
