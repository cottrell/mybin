#!/bin/bash -e
n=120
isort --line-length=$n --wrap-length=$n $*
black --skip-string-normalization -l $n $*
# autopep8 --max-line-length=$n -i $*
# do not write with autoflake just warn
autoflake $*
pylint --errors-only $*
