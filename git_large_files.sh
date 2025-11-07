#!/bin/bash
# find largest non-lfs files (blobs) across the entire Git history (all branches, tags, etc.)
FILENAME=./git_large_files_$(date +%Y%m%d).txt
echo "writing output to $FILENAME"
git rev-list --all --objects | git cat-file --batch-check='%(objectname) %(objecttype) %(objectsize) %(rest)' | grep blob | sort -k3nr > $FILENAME
echo "wrote output to $FILENAME" 
