#!/usr/bin/env python3
"""Check internal links in markdown files.

Usage:
    python3 check-links.py file1.md file2.md ...

Checks all relative markdown links and content-ref links point to existing files.
Skips external links (https://), anchor-only links (#section), and mailto links.

Exit code 0 if all links are valid, 1 if any are broken.
"""

import os
import re
import sys

MARKDOWN_LINK = re.compile(r'\[([^\]]*)\]\(([^)#\s]+?)(?:#[^)]*)?\)')
CONTENT_REF = re.compile(r'content-ref url="([^"]+)"')
SKIP_PREFIXES = ('http://', 'https://', 'mailto:', '#')
# GitBook hosts assets externally — these paths don't exist in the repo
SKIP_PATHS = ('.gitbook/assets/',)


def check_file(filepath):
    broken = []
    filedir = os.path.dirname(filepath)

    with open(filepath, encoding='utf-8') as f:
        for lineno, line in enumerate(f, 1):
            # Markdown links: [text](path) or [text](path#anchor)
            for m in MARKDOWN_LINK.finditer(line):
                target = m.group(2)
                if any(target.startswith(p) for p in SKIP_PREFIXES):
                    continue
                resolved = os.path.normpath(os.path.join(filedir, target))
                if any(s in resolved for s in SKIP_PATHS):
                    continue
                if not os.path.exists(resolved):
                    broken.append((lineno, target, resolved))

            # Content-ref links: {% content-ref url="path" %}
            for m in CONTENT_REF.finditer(line):
                target = m.group(1)
                if any(target.startswith(p) for p in SKIP_PREFIXES):
                    continue
                resolved = os.path.normpath(os.path.join(filedir, target))
                if any(s in resolved for s in SKIP_PATHS):
                    continue
                if not os.path.exists(resolved):
                    broken.append((lineno, target, resolved))

    return broken


def main():
    if len(sys.argv) < 2:
        print('Usage: python3 check-links.py file1.md file2.md ...')
        sys.exit(2)

    all_broken = {}
    for filepath in sys.argv[1:]:
        if not os.path.isfile(filepath):
            continue
        broken = check_file(filepath)
        if broken:
            all_broken[filepath] = broken

    if all_broken:
        total = sum(len(v) for v in all_broken.values())
        print(f'Found {total} broken link(s) in {len(all_broken)} file(s):\n')
        for filepath, broken in all_broken.items():
            for lineno, target, resolved in broken:
                print(f'  {filepath}:{lineno} -> {target}')
        sys.exit(1)
    else:
        print(f'All internal links OK ({len(sys.argv) - 1} files checked)')


if __name__ == '__main__':
    main()
