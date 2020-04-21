#!/bin/bash
n=300
isort $*
black --skip-string-normalization -l $n $*
autopep8 --max-line-length=$n -i $*
# do not write with autoflake just warn
autoflake $*
pylint --errors-only $*
