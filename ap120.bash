#!/bin/bash -e
n=120
type pylint | pip install isort black pylint
isort --line-length=$n --wrap-length=$n $*
black --skip-string-normalization -l $n $*
# autopep8 --max-line-length=$n -i $*
# do not write with autoflake just warn
autoflake $*
pylint --errors-only $*
