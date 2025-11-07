#!/usr/bin/env bash
# git_local_clone.sh
# 
# Purpose: Clone a local git repository, with special handling for repositories that are
# submodules of other repos. This script creates a fully self-contained clone that works
# offline without needing to reach out to remote repositories like GitHub.
# 
# The main use case is cloning a submodule from a parent repository's .git/modules/
# directory, ensuring all submodule references are resolved locally and the clone
# remains independent of the original parent repo structure.
# 
# Usage: ./git_local_clone.sh /path/to/source /path/to/dest

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 /path/to/source/repo /path/to/dest/repo" >&2
  exit 1
fi

set -euo pipefail

src=$(realpath "$1")
dest=$(realpath -m "$2")

echo "==> Copying $src  -->  $dest"

# verify source is a git repository
if ! git -C "$src" rev-parse --git-dir &>/dev/null; then
  echo "Error: $src is not a git repository" >&2
  exit 1
fi

# check if destination already exists and is not empty
if [ -d "$dest" ] && [ "$(ls -A "$dest" 2>/dev/null)" ]; then
  echo "Warning: Destination $dest already exists and is not empty" >&2
  read -p "Continue? This will delete existing content. [y/N] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
  fi
  echo "Removing existing directory..."
  rm -rf "$dest"
fi

# use git to find the actual git directory (handles submodules correctly)
echo "Finding git directory..."
gitdir=$(git -C "$src" rev-parse --git-dir)
if [[ "$gitdir" != /* ]]; then
  # if relative path, make it absolute from source directory
  gitdir="$src/$gitdir"
fi

echo "Cloning from git directory: $gitdir"
git clone "$gitdir" "$dest"
cd "$dest"

echo "==> Normalising submodules (if any)..."
# check if repo has submodules and handle them properly
if [ -f .gitmodules ] && [ -s .gitmodules ]; then
  echo "Found .gitmodules, processing submodules..."

  # The submodules' git directories are inside the source git directory
  # This works whether source is a regular repo or itself a submodule
  if [ -d "$gitdir/modules" ]; then
    echo "Copying submodule git directories from: $gitdir/modules"
    mkdir -p .git/modules
    cp -rf "$gitdir/modules"/* .git/modules/

    # Fix core.worktree paths in all copied submodule git directories
    echo "Fixing worktree paths in copied git directories..."
    find .git/modules -name config -type f | while read git_config; do
      # Unset core.worktree so git commands don't fail looking for old paths
      git config --file "$git_config" --unset core.worktree 2>/dev/null || true
    done

    echo "Copied submodule git directories"
  else
    echo "No submodule git directories found at $gitdir/modules"
  fi

  # Manually check out submodules from local .git/modules (no network calls!)
  echo "Manually checking out submodules from local git directories..."

  # Parse .gitmodules to get each submodule
  git config --file .gitmodules --name-only --get-regexp 'submodule\..*\.path' | while read config_key; do
    submodule_name=$(echo "$config_key" | sed 's/submodule\.\(.*\)\.path/\1/')
    submodule_path=$(git config --file .gitmodules "$config_key")

    echo "  Processing: $submodule_name at $submodule_path"

    # Find the actual git directory - could be under submodule_name or submodule_path
    git_module_dir=""
    if [ -d ".git/modules/$submodule_name" ]; then
      git_module_dir=".git/modules/$submodule_name"
    elif [ -d ".git/modules/$submodule_path" ]; then
      git_module_dir=".git/modules/$submodule_path"
    else
      # Try to find it by searching
      found=$(find .git/modules -type d -name "$(basename "$submodule_path")" 2>/dev/null | head -1)
      if [ -n "$found" ] && [ -d "$found" ]; then
        git_module_dir="$found"
      fi
    fi

    if [ -z "$git_module_dir" ]; then
      echo "    WARNING: Git directory not found for $submodule_name, skipping"
      continue
    fi

    echo "    Using git dir: $git_module_dir"

    # Get the commit that should be checked out (from the main repo's index)
    commit=$(git ls-tree HEAD "$submodule_path" | awk '{print $3}')

    if [ -z "$commit" ]; then
      echo "    WARNING: No commit found for $submodule_path in HEAD"
      continue
    fi

    # Check if the commit exists in the git directory
    if ! git --git-dir="$git_module_dir" cat-file -e "$commit" 2>/dev/null; then
      echo "    WARNING: Commit $commit not found in $git_module_dir, skipping"
      continue
    fi

    echo "    Checking out commit $commit"

    # Create the submodule directory
    mkdir -p "$submodule_path"

    # Create .git file that points to the git directory
    echo "gitdir: $(realpath --relative-to="$submodule_path" "$git_module_dir")" > "$submodule_path/.git"

    # Check out the files from the local git directory (suppress detached HEAD message)
    GIT_CONFIG_PARAMETERS="'advice.detachedHead=false'" git --git-dir="$git_module_dir" --work-tree="$submodule_path" checkout -f "$commit" 2>&1 | grep -v "detached HEAD" || true

    # Update the config to link this submodule
    git config -f .git/config "submodule.$submodule_name.active" "true"

    echo "    ✓ Checked out"
  done

  echo "Checking for nested submodules..."
  # Handle nested submodules recursively
  find .git/modules -mindepth 2 -name modules -type d | while read nested_modules_dir; do
    # Extract parent submodule path
    parent_path=$(echo "$nested_modules_dir" | sed 's|^\.git/modules/||' | sed 's|/modules$||')
    echo "  Found nested submodules under: $parent_path"
    # Note: nested submodules would need recursive handling here
    # For now, just report them
  done
else
  echo "No submodules found"
fi

echo "==> Repacking objects and removing alternates..."
# ensure it's self-contained
rm -f .git/objects/info/alternates
git repack -a -d
# git prune --expire=now --progress
# git gc --prune=now --aggressive

echo "==> Final verification:"
if git fsck --full 2>&1 > /dev/null; then
  echo "✓ Repository integrity check passed"
else
  echo "⚠ Repository integrity check found issues (but clone may still be usable)"
fi

# check if all submodules are properly configured
if [ -f .gitmodules ] && [ -s .gitmodules ]; then
  echo "Submodule status:"
  git submodule status || true
fi

echo
echo "✓ Repo successfully copied to: $dest"
echo
echo "If you want to shrink further, you can now run:"
echo "  cd '$dest' && git reflog expire --expire=now --all && git gc --prune=now --aggressive"
