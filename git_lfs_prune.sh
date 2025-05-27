#!/bin/bash
# Remove all LFS objects not referenced by recent commits (default: 10 days)
git lfs prune

# Remove all LFS objects not referenced by any commits
git lfs prune --verify-remote --force

# # Remove objects older than specific time
# git lfs prune --recent=1d  # keeps only last day
# git lfs prune --recent=0   # removes everything not in current commit
