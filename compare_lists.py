#!/usr/bin/env python3
"""
A simple script to find duplicate lines in files and report which entries unique to F1.
Usage: compare_lists.py file1 file2
"""

import sys


def compare_lists(f1, f2):
    intersection = list(set(f1).intersection(set(f2)))
    f1_unique = list(set(f1).difference(set(f2)))
    f2_unique = list(set(f2).difference(set(f1)))

    f_int = open("comp.inters", "w")
    f_1 = open("comp.1unique", "w")
    f_2 = open("comp.2unique", "w")

    for l in intersection:
        f_int.write(str(l))
    f_int.close()

    for l in f1_unique:
        f_1.write(str(l))
    f_1.close()

    for l in f2_unique:
        f_2.write(str(l))
    f_2.close()

    print("Intersection: %d" % len(intersection))
    print(''.join(intersection))
    print("%s unique elements: %d" % (sys.argv[1], len(f1_unique)))
    print(''.join(f1_unique))
    print("%s unique elements: %d" % (sys.argv[2], len(f2_unique)))
    print(''.join(f2_unique))


if __name__ == '__main__':
    f1 = open(sys.argv[1], "r").readlines()
    f2 = open(sys.argv[2], "r").readlines()
    compare_lists(f1, f2)
