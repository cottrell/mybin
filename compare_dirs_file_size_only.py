#!/usr/bin/env python3
import os
import sys
from pathlib import Path


def compare_directories(dir1, dir2):
    dir1_path = Path(dir1)
    dir2_path = Path(dir2)

    if not dir1_path.exists() or not dir2_path.exists():
        print("One or both directories don't exist")
        return

    dir1_files = {}
    dir2_files = {}

    for root, dirs, files in os.walk(dir1_path):
        for file in files:
            full_path = Path(root) / file
            rel_path = full_path.relative_to(dir1_path)
            dir1_files[rel_path] = full_path.stat().st_size

    for root, dirs, files in os.walk(dir2_path):
        for file in files:
            full_path = Path(root) / file
            rel_path = full_path.relative_to(dir2_path)
            dir2_files[rel_path] = full_path.stat().st_size

    dir2_files_only = set(dir2_files.keys()) - set(dir1_files.keys())
    dir1_files_only = set(dir1_files.keys()) - set(dir2_files.keys())

    if dir1_files_only:
        print(f"Files only in {dir1}:")
        for rel_path in sorted(dir1_files_only):
            print(f"{rel_path} {dir1_files[rel_path]} bytes")

    if dir2_files_only:
        print(f"Files only in {dir2}:")
        for rel_path in sorted(dir2_files_only):
            print(f"{rel_path} {dir2_files[rel_path]} bytes")

    common_files = set(dir1_files.keys()) & set(dir2_files.keys())

    if not common_files:
        print("No files with matching names found")
        return

    print(f"Found {len(common_files)} files with matching names:")
    print("-" * 60)

    any_different = False
    for rel_path in sorted(common_files):
        size1 = dir1_files[rel_path]
        size2 = dir2_files[rel_path]
        status = "SAME" if size1 == size2 else "DIFFER"
        if status == "DIFFER":
            any_different = True
            print(f"{rel_path} {size1} bytes vs {size2} bytes")
    if not any_different:
        print("All files with matching names have the same size.")
    


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python compare_dirs.py <dir1> <dir2>")
        sys.exit(1)

    compare_directories(sys.argv[1], sys.argv[2])
