#!/usr/bin/env python3
import os
import sys
import re
import glob

# Updates ./_sidebar.md with local .md files and subdirectories (next level only).
#
# Usage:
#   update_docsify_sidebar.sh           # Overwrites ./_sidebar.md
#   update_docsify_sidebar.sh [SECTION] # Inserts/updates entries indented under "* SECTION"
#   update_docsify_sidebar.sh -h        # Show help and usage notes
#
# Intended Workflow:
# - Docsify native multi-sidebar: each folder maintains its own small, scoped
#   _sidebar.md for its immediate children only. Docsify automatically swaps sidebars
#   when entering a folder.
# - Run explicitly in <dirA>, then <dirA>/<dirB>, etc. Avoids blindly littering
#   _sidebar.md into code/data/notebook folders.
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

def get_entry(path, is_dir=False):
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
        cwd = os.getcwd().lower()
        title = "Research Hub" if "research" in cwd else ("Operations Hub" if "operations" in cwd else ("Portfolio Hub" if "portfolio" in cwd else "Overview"))
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

def main():
    if len(sys.argv) > 1 and sys.argv[1] in ['-h', '--help']:
        print("""Usage: update_docsify_sidebar.sh [SECTION]

Updates ./_sidebar.md with local .md files and subdirectories (next-level only).

Usage:
  update_docsify_sidebar.sh           # Overwrites ./_sidebar.md in current directory
  update_docsify_sidebar.sh [SECTION] # Inserts/updates entries under "* SECTION"
  update_docsify_sidebar.sh -h        # Show this help

Intended Workflow:
  - Scoped per directory: Each docs folder maintains its own small _sidebar.md for its
    immediate children. Docsify automatically swaps sidebars when navigating into folders.
  - Run explicitly in <dirA>, then <dirA>/<dirB>, etc. as new sections are added.
  - Refresh all existing sidebars in a tree:
      find . -name "_sidebar.md" -not -path "*/.*" -execdir update_docsify_sidebar.sh \\;""")
        sys.exit(0)

    section = sys.argv[1] if len(sys.argv) > 1 and not sys.argv[1].startswith('-') else None
    sidebar_file = "_sidebar.md"

    # Scan directories
    entries = []
    for d in sorted(os.listdir('.')):
        if d.startswith('.'):
            continue
        if os.path.isdir(d):
            # Include if directory has md files, index, or _sidebar.md
            has_md = glob.glob(os.path.join(d, '*.md')) or glob.glob(os.path.join(d, '**/*.md'), recursive=True)
            has_sidebar = os.path.isfile(os.path.join(d, '_sidebar.md'))
            if has_md or has_sidebar:
                entries.append(get_entry(d, is_dir=True))

    # Scan .md files
    for f in sorted(os.listdir('.')):
        if f.startswith('.') or f in ['_sidebar.md', '_navbar.md']:
            continue
        if os.path.isfile(f) and f.endswith('.md'):
            entries.append(get_entry(f, is_dir=False))

    # Sort: Hub first, dated descending (newest first), non-dated topics alphabetical
    g0 = [e for e in entries if e['priority'] == 0]
    g1 = sorted([e for e in entries if e['priority'] == 1], key=lambda x: x['sort_key'], reverse=True)
    g2 = sorted([e for e in entries if e['priority'] == 2], key=lambda x: x['sort_key'])

    ordered = g0 + g1 + g2

    if section:
        # Indented under section
        indent = "  "
        section_lines = [f"{indent}* [{e['title']}]({e['link']})" for e in ordered]
        
        # Read existing file
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
                    # Empty line can delimit section
                    pass
                # Drop old indented entries under this section to replace with cleanly ordered ones
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
        # Full rewrite of local directory sidebar with clean order
        lines = []
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

        with open(sidebar_file, 'w', encoding='utf-8') as f:
            f.writelines(lines)
        print(f"Generated {sidebar_file} with {len(ordered)} entries (newest first).")

if __name__ == '__main__':
    main()
