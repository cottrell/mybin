#!/usr/bin/env python
import datetime
import re
import sys
import os


def generate_mv_command(*files):
    # for now leave old filename and just prepend if necessary
    for filename in files:
        basename = os.path.basename(filename)
        dirname = os.path.dirname(filename)
        print(f'checking {dirname} {basename}', file=sys.stderr)
        # YYYYMMDD
        match = re.search(r'(?P<year>20\d\d)[.-]?(?P<month>\d\d)[.-]?(?P<day>\d\d)', basename)
        if match:
            try:
                g = match.groupdict()
                g = {k: int(v) for k, v in g.items()}
                date = datetime.date(g['year'], g['month'], g['day'])
                date_format = date.strftime('%Y-%m-%d')
            except ValueError:
                print(f'skipping {filename}', file=sys.stderr)
                continue
        else:
            # YYYYMM
            match = re.search(r'(?P<year>20\d\d)[.-]?(?P<month>\d\d)', basename)
            if match:
                try:
                    g = match.groupdict()
                    g = {k: int(v) for k, v in g.items()}
                    date = datetime.date(g['year'], g['month'], 1)
                    date_format = date.strftime('%Y-%m')
                except ValueError:
                    print(f'skipping {filename}', file=sys.stderr)
                    continue
            else:
                print(f'skipping {filename}', file=sys.stderr)
                continue
        if not filename.startswith(date_format):
            new_filename = os.path.join(dirname, date_format + '_' + basename)
            print(f"mv -v {filename} {new_filename}")


if __name__ == '__main__':
    import argh
    argh.dispatch_command(generate_mv_command)
