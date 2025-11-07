#!/bin/bash
# Find largest LFS files across Git history
FILENAME=./git_large_lfs_files_$(date +%Y%m%d).txt
echo "writing output to $FILENAME"
git rev-list --all --objects | sed 's/\s.*$//' | sort -u | while read obj; do
  if git cat-file -t "$obj" 2>/dev/null | grep -q '^blob$'; then
    git cat-file -p "$obj" 2>/dev/null | {
      IFS= read -r version_line
      if [[ $version_line == 'version https://git-lfs.github.com/spec/v1' ]]; then
        IFS= read -r oid_line
        IFS= read -r size_line
        if [[ $size_line == size\ * ]]; then
          size=${size_line#size }
          echo "$size $obj"
        fi
      fi
    }
  fi
done | sort -k1 -nr > $FILENAME
echo "wrote output to $FILENAME"
