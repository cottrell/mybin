#!/usr/bin/env python
import email
import subprocess
from email import policy
from pathlib import Path

import argh
from bs4 import BeautifulSoup


def clean_html(html):
    soup = BeautifulSoup(html, 'html.parser')
    for tag in soup.find_all(True):
        tag.attrs = {k: v for k, v in tag.attrs.items() if k in ('href', 'src', 'colspan', 'rowspan')}
    for div in soup.find_all('div'):
        div.name = 'p'
    for span in soup.find_all('span'):
        span.unwrap()
    for table in soup.find_all('table'):
        table['border'] = '1'
        table['cellpadding'] = '5'
    for cell in soup.find_all(['td', 'th']):
        cell['style'] = 'border: 1px solid black; padding: 5px;'
    return str(soup)


def extract(input_file: str, formats: str = 'raw,html,md,txt'):
    """Extract content from an .eml file. Formats: raw, html, md, txt."""
    input_path = Path(input_file)
    format_list = [f.strip() for f in formats.split(',')]

    with open(input_file, 'rb') as f:
        msg = email.message_from_binary_file(f, policy=policy.default)

    html_part = msg.get_body(preferencelist=('html',))
    text_part = msg.get_body(preferencelist=('plain',))
    raw_html = html_part.get_content() if html_part else None
    cleaned_html = clean_html(raw_html) if raw_html else None

    for fmt in format_list:
        if fmt == 'txt':
            if not text_part:
                print("No plain text part found.")
                continue
            content = text_part.get_content()
        elif fmt == 'raw':
            if not raw_html:
                print("No HTML part found.")
                continue
            content = raw_html
        elif fmt == 'html':
            if not cleaned_html:
                print("No HTML part found.")
                continue
            content = cleaned_html
        elif fmt == 'md':
            if not cleaned_html:
                print("No HTML part found.")
                continue
            result = subprocess.run(
                ['pandoc', '-f', 'html', '-t', 'gfm', '--wrap=none'], input=cleaned_html, text=True, capture_output=True
            )
            if result.returncode != 0:
                print(f"pandoc error: {result.stderr}")
                continue
            content = result.stdout
        else:
            print(f"Unknown format: {fmt}")
            continue

        ext = 'html' if fmt == 'raw' else fmt
        suffix = f'.raw.html' if fmt == 'raw' else f'.{ext}'
        output = input_path.with_suffix(suffix)
        with open(output, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Saved to {output}")


if __name__ == '__main__':
    argh.dispatch_command(extract)
