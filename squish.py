#!/usr/bin/env python3
"""
$ echo 'a a b c a c c d' | tr ' ' '\n' | ./squish.py
a
b
c
d
"""

import sys


def squish(gen):
    """uniquify list preserve order"""
    seen = set()
    for x in gen:
        if x not in seen and not seen.add(x):
            yield x


if __name__ == '__main__':
    for x in squish(sys.stdin):
        print(x.strip())
