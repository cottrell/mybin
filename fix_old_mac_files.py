#!/usr/bin/env python
import sys

filename = sys.argv[1]
fin = open(filename)
for x in fin:
    x = x.strip()
    for k in ['\x1d', '\x0b']:
        x = x.replace(k, '')
    sep = '\t'
    x = sep.join((xx.strip() for xx in x.split(sep)))
    print(x)
