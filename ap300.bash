#!/bin/bash -e
n=300
isort --line-length=$n --wrap-length=$n $*
# use black in 120 mode it mangles dictionaries otherwise? Or was this just luck in one case?
black --skip-string-normalization -l $n $*
# autopep8 --max-line-length=$n -i $*
# see also yapf
# do not write with autoflake just warn
autoflake $*
pylint --errors-only $*
