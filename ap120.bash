
# LINE_LENGTH=120
#
# type ruff | uv pip install isort black ruff
#
# # Sort imports
# isort --line-length=$LINE_LENGTH --profile=black "$@"
#
# # Format code
# black --skip-string-normalization --line-length=$LINE_LENGTH "$@"
#
# # Check for unused imports and variables (warn only, no removal)
# ruff check --select F401,F841 --no-fix --line-length=$LINE_LENGTH "$@"
#
# # Lint for errors only
# ruff check --select E --no-fix --line-length=$LINE_LENGTH "$@"

#!/bin/bash -e

LINE_LENGTH=120

# Install if Ruff missing (proxy for all tools)
if ! command -v ruff >/dev/null 2>&1; then
    uv pip install isort black ruff
fi

# Sort imports
isort --line-length="$LINE_LENGTH" --profile=black "$@"

# Format code
black --skip-string-normalization --line-length="$LINE_LENGTH" "$@"

# Lint: unused imports/vars + errors (warn only)
ruff check --select E,F401,F841 --no-fix --line-length="$LINE_LENGTH" "$@"
