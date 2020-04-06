def monkey_patch_pandas():
    import pandas as pd
    import functools
    @functools.wraps(pd.Series.str.contains)
    def _grep(self, *args, **kwargs):
        if not hasattr(self, '_greppable'):
            self._greppable = pd.Series(self.to_csv().split('\n')[1:-1])
        i = self._greppable.str.contains(*args, **kwargs)
        return self.iloc[i.values]
    pd.DataFrame.grep = _grep

try:
    # from pylab import *
    # %load_ext line_profiler
    import pandas as pd
    import numpy as np
    import pandas
    from importlib import reload
    line_width = 1000
    np.set_printoptions(linewidth=line_width)
    pd.options.display.width = line_width
    pd.options.display.max_columns = 100
    pd.options.display.max_rows = 1000
    pd.options.display.min_rows = 40
    pd.options.display.width = 1000 # never wrap

    # import jedi
    # jedi.settings.case_insensitive_completion = False

    # crashes on osx from plotting? is this still needed
    from sys import platform as sys_pf
    if sys_pf == 'darwin':
        print('using darwing tkagg')
        import matplotlib
        matplotlib.use("TkAgg")

    monkey_patch_pandas()

except Exception as e:
    print('skipping startup/onstart.py due to exceptions')
    print(e)
