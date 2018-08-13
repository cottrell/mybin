try:
    # from pylab import *
    import pandas as pd
    import numpy as np
    import pandas
    from imp import reload
    # pandas.set_option('display.width', 200)
    pd.options.display.width = 300
    pd.options.display.max_columns = 20
    pandas.set_option('max.rows', 300)
    import jedi
    jedi.settings.case_insensitive_completion = False
except Exception as e:
    print('skipping startup/a.py due to exceptions')
    print(e)
