#!/usr/bin/env python3
"""Move Done backlog tasks from tasks/ to completed/."""
from __future__ import annotations
import re
import sys
from pathlib import Path

ROOT = Path.cwd()
TASKS = ROOT / "backlog" / "tasks"
COMPLETED = ROOT / "backlog" / "completed"


def get_status(path: Path) -> str | None:
    for line in path.read_text(errors="replace").splitlines():
        m = re.match(r"^status:\s*(.+)", line)
        if m:
            return m.group(1).strip()
        if line.startswith("---") and path != path:  # stop at end of frontmatter
            break
    return None


def main(dry_run: bool = False) -> None:
    COMPLETED.mkdir(exist_ok=True)
    moved = 0
    for task in sorted(TASKS.glob("*.md")):
        if get_status(task) == "Done":
            dest = COMPLETED / task.name
            if dest.exists():
                print(f"  skip (exists): {task.name}")
                continue
            if dry_run:
                print(f"  would move: {task.name}")
            else:
                task.rename(dest)
                print(f"  moved: {task.name}")
            moved += 1
    print(f"\n{'Would move' if dry_run else 'Moved'} {moved} task(s).")


if __name__ == "__main__":
    main(dry_run="--dry-run" in sys.argv)
