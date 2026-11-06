#!/usr/bin/env bash
# Preview files graphify would read (its own detect()).
# Usage:
#   graphify-files.py [path] [depth]
#   graphify-files.py --quiet [path]
#   graphify-files.py --grep [path]
set -euo pipefail

py="$(dirname "$(readlink -f "$(command -v graphify)")")/python"
exec "$py" -W ignore - "$@" <<'PY'
import sys
from pathlib import Path
from collections import Counter
from graphify.detect import detect

try:
    from graphify.watch import _read_build_excludes, _read_build_gitignore
except ImportError:
    sys.exit("graphify-files: graphify internals changed (watch._read_build_*); update this script")

# Parse arguments
args = sys.argv[1:]
mode = "summary"  # "summary", "quiet", "grep"

if "--quiet" in args:
    mode = "quiet"
    args.remove("--quiet")
elif "-q" in args:
    mode = "quiet"
    args.remove("-q")
elif "--grep" in args or "--grep-format" in args:
    mode = "grep"
    if "--grep" in args: args.remove("--grep")
    if "--grep-format" in args: args.remove("--grep-format")

target_path = args[0] if len(args) > 0 else "."
depth = int(args[1]) if len(args) > 1 else 2

root = Path(target_path).resolve()
out = root / "graphify-out"
r = detect(root, extra_excludes=_read_build_excludes(out) or None, gitignore=_read_build_gitignore(out))

# Flatten kept files (INCLUDED IN GRAPH)
kept_files = []
for file_type, flist in r.get("files", {}).items():
    for f in flist:
        p = Path(f) if isinstance(f, (str, Path)) else Path(f.get("path", ""))
        try:
            rel = p.relative_to(root)
        except ValueError:
            rel = p
        kept_files.append((str(rel), file_type))

kept_files.sort(key=lambda x: x[0])

# Flatten ignored files (SKIPPED_IGNORED - matched .gitignore / .graphifyignore)
ignored_files = []
for p in r.get("ignored", []):
    p_str = str(p)
    if p_str.startswith(str(root)):
        try:
            rel = Path(p).relative_to(root)
            ignored_files.append(str(rel) + ("/" if p_str.endswith("/") else ""))
        except ValueError:
            ignored_files.append(p_str)
    else:
        ignored_files.append(p_str)

ignored_files.sort()

# Flatten noise dirs (SKIPPED_NOISE - auto-pruned build/cache dirs)
noise_dirs = []
for p in r.get("pruned_noise_dirs", []):
    try:
        rel = Path(p).relative_to(root)
        noise_dirs.append(str(rel) + "/")
    except ValueError:
        noise_dirs.append(str(p))

noise_dirs.sort()

# Flatten sensitive files (SKIPPED_SENSITIVE)
sensitive_files = []
for p in r.get("skipped_sensitive", []):
    try:
        rel = Path(p).relative_to(root)
        sensitive_files.append(str(rel))
    except ValueError:
        sensitive_files.append(str(p))

sensitive_files.sort()

# Flatten unclassified files (SKIPPED_UNCLASSIFIED - unsupported extensions/binaries)
unclassified_files = []
for p in r.get("unclassified", []):
    try:
        rel = Path(p).relative_to(root)
        unclassified_files.append(str(rel))
    except ValueError:
        unclassified_files.append(str(p))

unclassified_files.sort()

# OUTPUT FORMATS
if mode == "quiet":
    for f, _ in kept_files:
        print(f)

elif mode == "grep":
    for f, ftype in kept_files:
        print(f"KEPT\t{ftype}\t{f}")
    for f in ignored_files:
        print(f"SKIPPED_IGNORED\tignore\t{f}")
    for d in noise_dirs:
        print(f"SKIPPED_NOISE\tdir\t{d}")
    for f in sensitive_files:
        print(f"SKIPPED_SENSITIVE\tsecret\t{f}")
    for f in unclassified_files:
        print(f"SKIPPED_UNCLASSIFIED\tunknown\t{f}")

else:
    kept_counts = Counter()
    types_counter = Counter()
    for f, ftype in kept_files:
        parts = Path(f).parts
        d = "/".join(parts[:min(depth, len(parts) - 1)]) or "."
        kept_counts[d] += 1
        types_counter[ftype] += 1

    print(f"=== INCLUDED IN GRAPH ({r['total_files']} files, {r['total_words']:,} words) ===")
    print(f"Breakdown: {dict(types_counter)}")
    for d, n in kept_counts.most_common():
        print(f"  {n:6}  {d}")

    print(f"\n=== EXCLUDED FROM GRAPH ===")
    print(f"  SKIPPED_IGNORED      ({len(ignored_files):5} files): Explicitly excluded by .gitignore or .graphifyignore rules")
    print(f"  SKIPPED_NOISE        ({len(noise_dirs):5} dirs ): Build artifacts, node_modules, target, __pycache__")
    print(f"  SKIPPED_SENSITIVE    ({len(sensitive_files):5} files): Passwords, private keys, .env files")
    print(f"  SKIPPED_UNCLASSIFIED ({len(unclassified_files):5} files): Unsupported extensions or raw binary files (not code/doc/image/paper)")
    print("\nNote: Only KEPT files enter graphify. All SKIPPED_* items are completely excluded.")
    print("Use --grep to see every single file with its SKIPPED_* tag.")
PY
