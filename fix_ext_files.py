#!/usr/bin/env python
import sys
import argh
import shutil
import os

def fix_ext_files(ext, *filenames, outdir=None):
    """this was for fixing old mac files that had no extension in filename and were not being read properly. Mostly images."""
    if outdir is not None:
        os.makedirs(outdir, exist_ok=True)
    else:
        outdir = '.'
    for f in filenames:
        if os.path.isdir(f):
            print(f'skipping {f} because is dir')
            continue
        dest = f'{outdir}/{f}.{ext}'
        print(f'{f} -> {dest}')
        if os.path.exists(dest):
            raise Exception(f'{dest} exists!')
        shutil.move(f, dest)


if __name__ == '__main__':
    argh.dispatch_command(fix_ext_files)

