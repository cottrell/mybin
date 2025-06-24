#!/bin/bash
type ruff > /dev/null || uv pip install ruff
# autoflake --verbose --in-place --remove-all-unused-import $*
ruff check --select F401 --fix --show-fixes "$@"
