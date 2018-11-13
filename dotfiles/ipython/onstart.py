try:
    # from pylab import *
    import pandas as pd
    import numpy as np
    import pandas
    from importlib import reload
    # pandas.set_option('display.width', 200)
    line_width = 300
    np.set_printoptions(linewidth=line_width)
    pd.options.display.width = line_width
    pd.options.display.max_columns = 100
    pandas.set_option('max.rows', 1000)
    import jedi
    jedi.settings.case_insensitive_completion = False
    # crashes on osx from plotting?
    from sys import platform as sys_pf
    if sys_pf == 'darwin':
        import matplotlib
        matplotlib.use("TkAgg")
except Exception as e:
    print('skipping startup/a.py due to exceptions')
    print(e)
