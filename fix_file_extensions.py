#!/usr/bin/env python
# probably python 3 osx only very hack
import glob
import os
import shutil
import subprocess
import sys


def check_and_maybe_fix_files(directory):
    directory = os.path.abspath(directory)
    files = glob.glob(os.path.join(directory, '**'), recursive=True)
    cmd = ['file'] + files
    output = subprocess.check_output(cmd)
    output = output.decode().split('\n')
    filetype_to_extension_mapping = dict(postscript='ps', jpeg='jpg', ascii='txt', pjl='ps')
    good_filetypes = list()
    ignored_filetypes = ['empty', 'hp']
    auto_accept_filetypes = list()
    cmds = list()
    outputfilename = '_run_this_to_move_files.sh'
    fout = open(outputfilename, 'w')
    for row in output:
        row = row.strip()
        if not row:
            continue
        res = row.strip().split(':')
        filename, filetype_full = res[0].strip(), res[1].strip()
        filetype = filetype_full.split()[0].lower()
        if filetype == 'directory':
            continue
        filetype = filetype_to_extension_mapping.get(filetype, filetype)
        if filetype in ignored_filetypes:
            continue
        extension = None
        if '.' in filename[-5:]:
            filename_no_ext, extension = filename.rsplit('.', 1)
            extension = extension.lower()
        if extension in {'enc', 'xlsx', 'pdf', 'csv', 'tex', 'gz', 'bib', 'rtf', 'odt', 'xls', 'md', 'json', 'h5', 'txt', 'py', 'sh', 'bash', 'pyc', 'tax', 'doc', 'docx', 'css', 'html', 'bin'}:  # HARD CODE THIS, PROBABLY FILES OK
            continue
        if extension is None:
            filename_no_ext = filename
        if extension != filetype:
            print('FAIL: {} is not {}'.format(filename, filetype_full))
            dest = '.'.join([filename_no_ext, filetype])
            res = None
            if filetype in auto_accept_filetypes:
                res = 'a'
            else:
                while res not in {'a', 'n', 'y'}:
                    res = input('move {} -> {} ({})? [n]ya'.format(os.path.basename(filename), os.path.basename(dest), filetype_full))
            if res == 'y' or res == 'a':
                cmd = 'mv -v "{}" "{}" # ({})'.format(filename, dest, filetype_full)
                print(cmd)
                print(cmd, file=fout)
                if res == 'a':
                    auto_accept_filetypes.append(filetype)
                good_filetypes.append(filetype)
            elif res == 'n':
                ignored_filetypes.append(filetype)
        else:
            print('PASS: {} is {}'.format(filename, filetype_full))
            good_filetypes.append(filetype)
    good_filetypes = sorted(list(set(good_filetypes)))
    ignored_filetypes = sorted(list(set(ignored_filetypes)))
    print('good file types: {}'.format(good_filetypes))
    print('ignored file types: {}'.format(ignored_filetypes))


def main(*directories):
    assert len(directories) > 0
    for directory in directories:
        check_and_maybe_fix_files(directory)


if __name__ == '__main__':
    directories = sys.argv[1:]
    main(*directories)
