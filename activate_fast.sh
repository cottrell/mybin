#!/bin/sh
# source activate $env is slow so I do this, it will not clear the stack of PATHs if you call it again and again
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export ANACONDA_BASE_DIR=~/anaconda3
export CONDA_DEFAULT_ENV=$1
export CONDA_EXE=$ANACONDA_BASE_DIR/bin/conda
export CONDA_PREFIX=$ANACONDA_BASE_DIR/envs/$1
export CONDA_PROMPT_MODIFIER='(37) '
export CONDA_PYTHON_EXE=/Users/davidcottrell/anaconda3/bin/python
export CONDA_SHLVL=1

export _CONDA_EXE=$ANACONDA_BASE_DIR/bin/conda
export _CONDA_ROOT=$ANACONDA_BASE_DIR
export _CONDA_SHELL_FLAVOR=bash

if [[ $# -lt 1 ]]; then
    echo usage: source activate_fast.sh pyenv
    return 1
fi


if [[ ! -d $CONDA_PREFIX ]]; then
    echo $CONDA_PREFIX dir does not exist!
    return 1
fi

# check is empty or check exists? check is empty for now. corner case if you really wanted empty PATH or PS1
if [[ "$CONDA_PS1_BACKUP" ]]; then
    PS1="($1) $CONDA_PS1_BACKUP"
else
    CONDA_PS1_BACKUP=$PS1
    PS1="($1) $PS1"
fi


if [[ "$CONDA_PATH_BACKUP" ]]; then
    PATH=$ANACONDA_BASE_DIR/envs/$1/bin:$CONDA_PATH_BACKUP
else
    PATH=$ANACONDA_BASE_DIR/envs/$1/bin:$PATH
fi

export CONDA_PS1_BACKUP
export PS1
export PATH
