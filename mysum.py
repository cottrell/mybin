#!/usr/bin/env python3
"""
echo '123 sadf 34 12 3.22222 more' | tr ' ' '\n' | ./mysum.py
"""

import sys

s = 0
for x in sys.stdin:
    x = x.strip()
    try:
        x = float(x)
        s += x
    except Exception as e:
        pass
print(s)

