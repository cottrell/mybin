#!/bin/bash

# Configurable batch size
NBATCH=${1:-1000}


# Directories and file types to clean
PATTERNS=("*.log" "__pycache__" "*.so" "*.o" "*.tmp" "*.swp" "*.bak" "*.pyc" "*.pyo")

# Collect all matching files
FILES=()
for pattern in "${PATTERNS[@]}"; do
    while IFS= read -r -d '' file; do
        FILES+=("$file")
    done < <(find . -type f -name "$pattern" -print0 2>/dev/null)
done

# Collect matching directories (like __pycache__)
for pattern in "${PATTERNS[@]}"; do
    while IFS= read -r -d '' dir; do
        FILES+=("$dir")
    done < <(find . -type d -name "$pattern" -print0 2>/dev/null)
done

# Function to confirm and delete in batches
clean_files() {
    local count=0
    local batch=()
    for file in "${FILES[@]}"; do
        batch+=("$file")
        ((count++))

        if ((count % NBATCH == 0 || count == ${#FILES[@]})); then
            echo "Found ${#batch[@]} files to delete in this batch:"
            printf '%s\n' "${batch[@]}"
            read -p "Delete these files? (y/n) " CONFIRM
            if [[ "$CONFIRM" == "y" ]]; then
                rm -rf "${batch[@]}"
                echo "Deleted ${#batch[@]} files."
            else
                echo "Skipping this batch."
            fi
            batch=()
        fi
    done
}

# Run cleanup if there are files to delete
if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "No files to clean."
else
    clean_files
fi
