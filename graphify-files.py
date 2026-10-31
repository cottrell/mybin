#!/usr/bin/env bash
# Preview files graphify would read (its own detect()). Usage: graphify-files [path] [depth]
set -euo pipefail
py="$(dirname "$(readlink -f "$(command -v graphify)")")/python"
exec "$py" -W ignore - "${1:-.}" "${2:-2}" <<'PY'
import sys
from pathlib import Path
from collections import Counter
from graphify.detect import detect
try:
    from graphify.watch import _read_build_excludes, _read_build_gitignore
except ImportError:
    sys.exit("graphify-files: graphify internals changed (watch._read_build_*); update this script")
root = Path(sys.argv[1]).resolve(); depth = int(sys.argv[2]); out = root / "graphify-out"
r = detect(root, extra_excludes=_read_build_excludes(out) or None, gitignore=_read_build_gitignore(out))
kept, types = Counter(), Counter()
for t, fs in r['files'].items():
    for p in fs:
        rel = Path(p).relative_to(root)
        kept['/'.join(rel.parts[:min(depth, len(rel.parts) - 1)]) or '.'] += 1; types[t] += 1
print(f"KEPT {r['total_files']} files, {r['total_words']:,} words  {dict(types)}")
for d, n in kept.most_common(): print(f"  {n:6}  {d}")
print(f"IGNORED {len(r['ignored'])}  (dirs end in /)")
for p in r['ignored']: print('  ', Path(p).relative_to(root) if p.startswith(str(root)) else p)
print(f"also: sensitive={len(r['skipped_sensitive'])} unclassified={len(r['unclassified'])} noise_dirs={r['pruned_noise_dirs']}")
PY
