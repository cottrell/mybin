#!/bin/bash -e
n=300
isort $*
# use black in 120 mode it mangles dictionaries otherwise? Or was this just luck in one case?
# black --skip-string-normalization -l $n $*
autopep8 --max-line-length=$n -i $*
# do not write with autoflake just warn
autoflake $*
pylint --errors-only $*
