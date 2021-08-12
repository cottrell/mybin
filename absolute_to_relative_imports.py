#!/usr/bin/env python
import ast
import contextlib
import glob
import os
import pathlib
import sys
import tempfile


@contextlib.contextmanager
def temp_then_atomic_move(filename, dir=False, tempdir=None, prefix=".tmp_"):
    if tempdir is None:
        tempdir = os.path.dirname(filename)  # this is usually a bad idea
    if not os.path.exists(tempdir):
        os.makedirs(tempdir)
    if dir:
        temp = tempfile.mkdtemp(prefix=prefix, dir=tempdir)
    else:
        temp = tempfile.mktemp(prefix=prefix, dir=tempdir)
    yield temp
    print("atomic {} -> {}".format(temp, filename))
    os.rename(temp, filename)


def handle_file_inplace(filename, directory):
    relname = filename.relative_to(directory)
    depth = len(relname.as_posix().split('/')) - 1
    print(f'filename={filename}, toplevel_module={directory.name}, depth={depth}')
    replace_txt = '.' * depth
    # there might be a way of doing this in one go with ast from the top level, not sure
    tree = ast.parse(open(filename).read())
    for i, x in enumerate(tree.body):
        if isinstance(x, ast.ImportFrom):
            module = x.module
            if module is None:
                continue  # is relative already
            elif module.startswith(directory.name):
                module = module.replace(directory.name, replace_txt)
                print(f'\t{x.module} -> {module}')
                # tree.body[i].module = module
                x.module = module
    code = ast.unparse(tree)
    with temp_then_atomic_move(filename) as filename_out:
        open(filename_out, 'w').write(code)


def run(directory):
    directory = pathlib.Path(directory)
    base = pathlib.Path(directory)
    filenames = base.glob('**/*.py')
    filenames = list(filenames)
    for f in filenames:
        handle_file_inplace(f, directory)


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Convert absolute to relative imports starting from some directory.')
    parser.add_argument('directory', default='.', type=str, help='Directory to scan')
    args = parser.parse_args()
    run(args.directory)
