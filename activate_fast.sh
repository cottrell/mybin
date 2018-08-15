#!/bin/sh
# source activate $env is slow so I do this
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ANACONDA_BASE_DIR=~/anaconda3

if [[ $# -le 1 ]]; then
    echo usage: prog env
    exit 1
fi

CONDA_PREFIX=$ANACONDA_BASE_DIR/envs/$1

if [[ ! -d $CONDA_PREFIX ]]; then
    echo $CONDA_PREFIX dir does not exist!
    exit 1
fi

# check is empty or check exists? check is empty for now. corner case if you really wanted empty PATH or PS1
if [[ "$CONDA_PS1_BACKUP" ]]; then
    PS1="($1) $CONDA_PS1_BACKUP"
else
    CONDA_PS1_BACKUP=$PS1
    PS1="($1) $PS1"
fi

CONDA_DEFAULT_ENV=$1

if [[ "$CONDA_PATH_BACKUP" ]]; then
    PATH=$ANACONDA_BASE_DIR/envs/$1/bin:$CONDA_PATH_BACKUP
else:
    PATH=$ANACONDA_BASE_DIR/envs/$1/bin:$PATH
fi
