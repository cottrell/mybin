#!/usr/bin/env python3
import os
import sys
import re
import glob
import subprocess

# Updates ./_sidebar.md with local .md files and subdirectories (next level only).
#
# Usage:
#   update_docsify_sidebar.sh [OPTIONS] [SECTION]
#
# Options:
#   update_docsify_sidebar.sh           # Overwrites ./_sidebar.md
#   update_docsify_sidebar.sh [SECTION] # Inserts/updates entries indented under "* SECTION"
#   update_docsify_sidebar.sh -h        # Show help and usage notes
#   --init-missing                      # Auto-generate _sidebar.md in included subdirs and git add
#   --touch-missing                     # Auto-touch empty _sidebar.md in included subdirs and git add
#   --no-prompt                         # Skip prompt for missing sub-sidebars
#
# Intended Workflow:
# - Docsify native multi-sidebar: each folder maintains its own small, scoped
#   _sidebar.md for its immediate children only. Docsify automatically swaps sidebars
#   when entering a folder.
# - Run explicitly in <dirA>, then <dirA>/<dirB>, etc. Avoids blindly littering
#   _sidebar.md into code/data/notebook folders.
# - If included subdirectories lack a _sidebar.md, the script prompts to initialize
#   and git add them to avoid 404s and broken relative links under `relativePath: true`.
# - Batch refresh existing sidebars only:
#     find . -name "_sidebar.md" -not -path "*/.*" -execdir update_docsify_sidebar.sh \;
#
# Inclusion / Exclusion Rules:
# - Files: Scans top-level *.md. Excludes hidden files (.*), _sidebar.md, _navbar.md.
# - Dirs:  Included if containing any *.md (recursive) OR a _sidebar.md. Excludes hidden (.*).
#          Linked as `<dir>/`. Structure note:
#          - Neither <dir>/README.md nor <dir>/_sidebar.md is required for inclusion.
#          - If <dir>/README.md, readme.md, or index.md exists, its '# ' H1 is used as title.
#            Otherwise falls back to title-cased folder name.
# - Title: First '# ' header in file/index (brackets stripped, dates normalized).
# - Order: 1) Hub (README/INDEX) -> 2) Dated (newest first) -> 3) Alphabetical.

def clean_markdown_title(h1_text):
    cleaned = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', h1_text)
    cleaned = re.sub(r'[`*_]', '', cleaned)
    return cleaned.strip()

def extract_date(name):
    m = re.search(r'(\d{4}[-_]\d{2}[-_]\d{2})', name)
    if m:
        return m.group(1).replace('_', '-')
    m2 = re.search(r'(\b\d{8}\b|\b\d{8}[-_])', name)
    if m2:
        d = re.search(r'\d{8}', m2.group(0)).group(0)
        return f"{d[:4]}-{d[4:6]}-{d[6:8]}"
    return None

def title_case(s):
    words = re.split(r'[-_\s]+', s)
    res = []
    for w in words:
        if not w:
            continue
        if w.isupper() and len(w) > 1:
            res.append(w)
        elif w.lower() in ['and', '&', 'of', 'in', 'on', 'at', 'to', 'for', 'vs']:
            res.append(w.lower())
        else:
            res.append(w.capitalize())
    return ' '.join(res)

def get_entry(path, is_dir=False, parent_dir='.'):
    base = os.path.basename(path)
    if not is_dir and base.endswith('.md'):
        base = base[:-3]

    date_str = extract_date(base)
    
    # Inspect H1
    target = None
    if is_dir:
        for cand in ['README.md', 'readme.md', 'index.md']:
            cp = os.path.join(path, cand)
            if os.path.isfile(cp):
                target = cp
                break
    else:
        target = path

    h1 = None
    if target and os.path.isfile(target):
        try:
            with open(target, 'r', encoding='utf-8') as f:
                for line in f:
                    line = line.strip()
                    if line.startswith('# '):
                        h1 = clean_markdown_title(line[2:].strip())
                        break
        except Exception:
            pass

    link = f"{base}/" if is_dir else base

    if not date_str and h1:
        date_str = extract_date(h1)

    # Overview / Hub
    if base.upper() in ['README', 'INDEX']:
        curr_dir = os.path.basename(os.path.abspath(parent_dir)).lower()
        if curr_dir == 'research':
            title = "Research Hub"
        elif curr_dir == 'operations':
            title = "Operations Hub"
        elif curr_dir == 'portfolio':
            title = "Portfolio Hub"
        elif h1:
            title = h1
        else:
            title = "Overview"
        return {'link': link, 'title': title, 'priority': 0, 'sort_key': '0000-00-00'}

    if h1:
        title = h1
        # Ensure date is first in title: YYYY-MM-DD Title
        if date_str:
            clean_title = re.sub(r'^\[?\d{4}-\d{2}-\d{2}\]?:?\s*', '', title)
            clean_title = re.sub(r'\s*\(\d{4}-\d{2}-\d{2}\)$', '', clean_title)
            clean_title = re.sub(r'\s*\|\s*\d{4}-\d{2}-\d{2}$', '', clean_title)
            clean_title = re.sub(r'\s*-\s*\d{4}-\d{2}-\d{2}$', '', clean_title)
            title = f"{date_str} {clean_title.strip()}"
    else:
        clean_name = base
        if date_str:
            clean_name = re.sub(r'(\d{4}[-_]\d{2}[-_]\d{2}|\d{8})[-_]?', '', clean_name).strip('-_ ')
            formatted = title_case(clean_name) if clean_name else "Notes"
            title = f"{date_str} {formatted}"
        else:
            title = title_case(clean_name)

    if date_str:
        priority = 1
        sort_key = date_str
    else:
        priority = 2
        sort_key = title.lower()

    return {'link': link, 'title': title, 'priority': priority, 'sort_key': sort_key}

def is_git_repo(path='.'):
    try:
        res = subprocess.run(['git', 'rev-parse', '--is-inside-work-tree'], cwd=path, capture_output=True, text=True)
        return res.returncode == 0
    except Exception:
        return False

def git_add_files(files, cwd='.'):
    if not files:
        return
    try:
        subprocess.run(['git', 'add'] + files, cwd=cwd, check=True)
    except Exception as e:
        print(f"Warning: git add failed: {e}")

def scan_and_order(dir_path='.'):
    entries = []
    missing_sidebar_dirs = []
    for d in sorted(os.listdir(dir_path)):
        if d.startswith('.'):
            continue
        full_d = os.path.join(dir_path, d)
        if os.path.isdir(full_d):
            has_md = glob.glob(os.path.join(full_d, '*.md')) or glob.glob(os.path.join(full_d, '**/*.md'), recursive=True)
            has_sidebar = os.path.isfile(os.path.join(full_d, '_sidebar.md'))
            if has_md or has_sidebar:
                entries.append(get_entry(full_d, is_dir=True, parent_dir=dir_path))
                if not has_sidebar:
                    missing_sidebar_dirs.append(full_d)

    for f in sorted(os.listdir(dir_path)):
        if f.startswith('.') or f in ['_sidebar.md', '_navbar.md']:
            continue
        full_f = os.path.join(dir_path, f)
        if os.path.isfile(full_f) and f.endswith('.md'):
            entries.append(get_entry(full_f, is_dir=False, parent_dir=dir_path))

    g0 = [e for e in entries if e['priority'] == 0]
    g1 = sorted([e for e in entries if e['priority'] == 1], key=lambda x: x['sort_key'], reverse=True)
    g2 = sorted([e for e in entries if e['priority'] == 2], key=lambda x: x['sort_key'])
    return g0 + g1 + g2, missing_sidebar_dirs

def write_sidebar(dir_path, ordered):
    lines = []
    g0 = [e for e in ordered if e['priority'] == 0]
    g1 = [e for e in ordered if e['priority'] == 1]
    g2 = [e for e in ordered if e['priority'] == 2]
    if g0:
        for e in g0:
            lines.append(f"* [{e['title']}]({e['link']})\n")
        lines.append("\n")
    if g1:
        for e in g1:
            lines.append(f"* [{e['title']}]({e['link']})\n")
        lines.append("\n")
    if g2:
        for e in g2:
            lines.append(f"* [{e['title']}]({e['link']})\n")

    sidebar_file = os.path.join(dir_path, "_sidebar.md")
    with open(sidebar_file, 'w', encoding='utf-8') as f:
        f.writelines(lines)
    return sidebar_file

def main():
    if any(arg in ['-h', '--help'] for arg in sys.argv[1:]):
        print("""Usage: update_docsify_sidebar.sh [OPTIONS] [SECTION]

Updates ./_sidebar.md with local .md files and subdirectories (next-level only).

Options:
  -h, --help        Show this help
  --init-missing    Automatically generate missing _sidebar.md in included dirs and git add
  --touch-missing   Automatically touch empty _sidebar.md in included dirs and git add
  --no-prompt       Skip prompting for missing sub-sidebars

Intended Workflow:
  - Scoped per directory: Each docs folder maintains its own small _sidebar.md for its
    immediate children. Docsify automatically swaps sidebars when navigating into folders.
  - Run explicitly in <dirA>, then <dirA>/<dirB>, etc. as new sections are added.
  - If included subdirectories lack a _sidebar.md, you will be prompted to initialize
    and git add them (prevents Docsify 404s and broken relative links).
  - Refresh all existing sidebars in a tree:
      find . -name "_sidebar.md" -not -path "*/.*" -execdir update_docsify_sidebar.sh \\;""")
        sys.exit(0)

    init_missing = '--init-missing' in sys.argv
    touch_missing = '--touch-missing' in sys.argv
    no_prompt = '--no-prompt' in sys.argv

    pos_args = [a for a in sys.argv[1:] if not a.startswith('-')]
    section = pos_args[0] if pos_args else None
    sidebar_file = "_sidebar.md"

    ordered, missing_sidebar_dirs = scan_and_order('.')

    if section:
        indent = "  "
        section_lines = [f"{indent}* [{e['title']}]({e['link']})" for e in ordered]
        
        existing_lines = []
        if os.path.isfile(sidebar_file):
            with open(sidebar_file, 'r', encoding='utf-8') as f:
                existing_lines = f.readlines()

        sec_header = f"* {section}\n"
        out = []
        found_sec = False
        in_sec = False
        
        for line in existing_lines:
            if line.strip() == f"* {section}":
                found_sec = True
                in_sec = True
                out.append(line)
                for sl in section_lines:
                    out.append(sl + "\n")
                continue
            
            if in_sec:
                if line.startswith("* ") and not line.startswith(f"* {section}"):
                    in_sec = False
                    out.append(line)
                elif line.strip() == "":
                    pass
                continue
            out.append(line)

        if not found_sec:
            if out and not out[-1].endswith("\n"):
                out.append("\n")
            out.append(f"* {section}\n")
            for sl in section_lines:
                out.append(sl + "\n")

        with open(sidebar_file, 'w', encoding='utf-8') as f:
            f.writelines(out)
        print(f"Updated section '{section}' in {sidebar_file} with {len(ordered)} entries.")
    else:
        write_sidebar('.', ordered)
        print(f"Generated {sidebar_file} with {len(ordered)} entries (newest first).")

    # Handle missing sidebars in included subdirectories
    if missing_sidebar_dirs:
        mode = None
        if init_missing:
            mode = 'generate'
        elif touch_missing:
            mode = 'empty'
        elif not no_prompt and sys.stdin.isatty():
            print(f"\nNotice: {len(missing_sidebar_dirs)} included directories have no _sidebar.md:")
            for d in missing_sidebar_dirs:
                print(f"  - {os.path.normpath(d)}")
            try:
                ans = input("Initialize _sidebar.md and git add? [y (populate) / e (empty touch) / N (skip)]: ").strip().lower()
            except (EOFError, KeyboardInterrupt):
                ans = 'n'
                print()
            if ans in ['y', 'yes']:
                mode = 'generate'
            elif ans in ['e', 'empty']:
                mode = 'empty'
            else:
                mode = 'skip'
        else:
            print(f"Notice: {len(missing_sidebar_dirs)} included directories have no _sidebar.md (use --init-missing or --touch-missing).")

        if mode in ['generate', 'empty']:
            created_files = []
            for d in missing_sidebar_dirs:
                if mode == 'generate':
                    sub_ordered, _ = scan_and_order(d)
                    sp = write_sidebar(d, sub_ordered)
                else:
                    sp = os.path.join(d, "_sidebar.md")
                    with open(sp, 'w', encoding='utf-8') as f:
                        pass
                created_files.append(sp)
            action_desc = "Generated" if mode == 'generate' else "Touched empty"
            print(f"{action_desc} _sidebar.md in {len(created_files)} directories.")
            if is_git_repo('.'):
                git_add_files(created_files, cwd='.')
                print(f"Staged {len(created_files)} files with `git add`.")

if __name__ == '__main__':
    main()
