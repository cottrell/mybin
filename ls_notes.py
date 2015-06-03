#!/usr/bin/env python3
"""
WARNING: hack/trick behaviour depends on link name pointing to this script.

nls -> this_script
jls -> this_script
"""
import glob
import sys
import os
import re

HOME = os.getenv("HOME")
NOTES = os.path.join(HOME, "notes")

padding = " " * 3
def parse_line(line):
    line = line.rstrip()
    line = line.lstrip(" ")
    while "**" in line:
        line = line.replace("**",padding+"*")
    line = line.replace("* ", padding + "* ")
    line = line.replace("\t",padding)
    line = padding + line
    return(line)

def print_stuff(files):
   for f in files:
       print("%s:" % f)
       fin = open(f, 'r')
       for x in fin:
           x = x.strip(" \n")
           x = parse_line(x)
           print(x)
       print()
   print("Index:")
   for f in files:
       print(padding + f)

if __name__ == '__main__':
   script_name = os.path.basename(sys.argv[0])
   if script_name == 'jls':
       files = glob.glob(os.path.join(NOTES, "journal_*"))
   elif script_name == 'nls':
       files = glob.glob(os.path.join(NOTES, "note_*"))
   else:
       print("Link to this script as jls or nls.")
       print(script_name)
   files.sort(reverse=False)
   print_stuff(files)
