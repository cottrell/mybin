#!/bin/bash
n=300
isort $*
black -l $n $*
autopep8 --max-line-length=$n -i $*
