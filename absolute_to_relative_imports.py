#!/usr/bin/env python
"""
NOTE this currently will fail on things like:

import skfem

We need to trawl the entire file to replace skfem imports with references.

You can check for this in advance with string matching or hit alias.name == package.
"""
import ast
import contextlib
import glob
import os
import pathlib
import sys
import tempfile
import logging

logging.getLogger().setLevel(logging.INFO)


@contextlib.contextmanager
def temp_then_atomic_move(filename, dir=False, tempdir=None, prefix=".tmp_"):
    """Creating a tempfile and then atomically move it into place on successfull completion"""
    if tempdir is None:
        tempdir = os.path.dirname(filename)  # this is usually a bad idea
    if not os.path.exists(tempdir):
        os.makedirs(tempdir)
    if dir:
        temp = tempfile.mkdtemp(prefix=prefix, dir=tempdir)
    else:
        temp = tempfile.mktemp(prefix=prefix, dir=tempdir)
    yield temp
    logging.debug("atomic {} -> {}".format(temp, filename))
    os.rename(temp, filename)


def check_line(x, depth, directory):
    """For debug"""
    res = handle_line(x, depth, directory)
    logging.info(f' input: {ast.unparse(x)}')
    logging.info(f'output: {ast.unparse(res)}')
    return res

def handle_line(x, depth, directory):
    """Turn an ast line into relative import format using various hacks.

    * x is ast parsed line from body.
    * depth 0 means you are in blah.module.py, 1 is blah.module.here.py
    * directory is the module entry point i.e. "pandas/pandas"

    debug like this:
        f = ast.parse(open(filename).read())
        x = f.body[123]
        check_line(x, depth, directory)
    """
    if isinstance(directory, str):
        directory = pathlib.Path(directory)
    # replace_txt = '.' * depth
    if isinstance(x, ast.ImportFrom):
        module = x.module
        if module is not None and module.startswith(directory.name):
            logging.info(f'BRANCH Z {module}')
            # module = replace_txt + module[len(directory.name):]
            module = module[len(directory.name) + 1:]
            orig = ast.unparse(x)
            x.module = module
            x.level = depth + 1
            logging.info(f'depth={depth}: {orig} -> {ast.unparse(x)}')
        return [x]
    elif isinstance(x, ast.Import):
        # .names is a list of aliases with .name and .asname
        # each of this should simply go to a separate ImportFrom to keep it simple
        if not any([alias.name.startswith(directory.name) for alias in x.names]):
            return [x]
        else:
            unchanged = list()
            old_import_aliases_to_keep = list()
            new_importfroms = list()
            for alias in x.names:
                # alias are this: import name as asname ... so need to replace name, keep asname
                if not alias.name.startswith(directory.name):
                    old_import_aliases_to_keep.append(alias)
                else:
                    # import mod.this.that turns into from ..this import that
                    # which is module=None, level=2, alias(that)
                    if alias.name == directory.name:
                        # example "import skfem" ... turn this into from ... import skfem
                        # which will go *above* the directory level and will break for standalone packages
                        logging.info('BRANCH A')
                        import_from = ast.ImportFrom(None, [ast.alias(alias.name, alias.asname)], level=depth + 2)
                    else:
                        logging.info('BRANCH B')
                        module, name = alias.name.rsplit('.', 1)
                        new_module = module[len(directory.name) + 1:]
                        new_module = None if new_module == '' else new_module
                        level = depth + 1
                        logging.debug(f'\t{module} -> {new_module} (level={level})')
                        import_from = ast.ImportFrom(new_module, [ast.alias(name, alias.asname)], level)
                    logging.info(f'depth={depth}: {ast.unparse(x)} -> {ast.unparse(import_from)}')
                    new_importfroms.append(import_from)
            if old_import_aliases_to_keep:
                unchanged = [ast.Import(old_import_aliases_to_keep)]
            return unchanged + new_importfroms
    else:
        return [x]


def handle_file_inplace(filename, directory, dry_run=False):
    relname = filename.relative_to(directory)
    depth = len(relname.as_posix().split('/')) - 1
    logging.info(f'filename={filename}, relname={relname}, toplevel_module={directory.name}, depth={depth}')
    tree = ast.parse(open(filename).read())
    new_body = list()
    for i, x in enumerate(tree.body):
        lines = handle_line(x, depth, directory)
        new_body.extend(lines)

    if not dry_run:
        tree.body = new_body
        code = ast.unparse(tree)
        with temp_then_atomic_move(filename) as filename_out:
            open(filename_out, 'w').write(code)


def run(directory, dry_run=False, filenames=None):
    """Crawl all python files and parse the ast to change absolute imports into relative ones.

    There might be a way of doing this in one go with ast from the top level, not sure.
    Currently mangles line indentation and removes empty lines so not great.
    What does black or autopep8 use?
    """
    directory = pathlib.Path(directory)
    base = pathlib.Path(directory)
    if not filenames:
        filenames = base.glob('**/*.py')
        filenames = list(filenames)
    else:
        filenames = [pathlib.Path(f) for f in filenames]
    for f in filenames:
        handle_file_inplace(f, directory, dry_run)


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='Convert absolute to relative imports starting from some directory.')
    parser.add_argument('directory', default='.', type=str, help='Directory to scan')
    parser.add_argument('files', nargs='*', help='files to scan')
    parser.add_argument("--dry-run", type=bool, nargs='?', const=True, default=False, help="Dry run.")
    args = parser.parse_args()
    # print(args.directory, args.dry_run, args.files)
    run(args.directory, args.dry_run, filenames=args.files)
