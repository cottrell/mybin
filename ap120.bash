#!/bin/bash -e
# n=120
# type pylint | uv pip install isort black pylint autoflake
# isort --line-length=$n --wrap-length=$n $*
# black --skip-string-normalization -l $n $*
# # autopep8 --max-line-length=$n -i $*
# # do not write with autoflake just warn
# autoflake $*
# pylint --errors-only $*

LINE_LENGTH=120

type ruff | uv pip install isort black ruff

# Sort imports
isort --line-length=$LINE_LENGTH --profile=black "$@"

# Format code
black --skip-string-normalization --line-length=$LINE_LENGTH "$@"

# Check for unused imports and variables (warn only, no removal)
ruff check --select F401,F841 --no-fix --line-length=$LINE_LENGTH "$@"

# Lint for errors only
ruff check --select E --no-fix --line-length=$LINE_LENGTH "$@"
