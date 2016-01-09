def iris():
    import pandas
    import sklearn.datasets as datasets
    d = datasets.load_iris()
    c = pandas.Categorical.from_codes(d.target, d.target_names)
    df = pandas.DataFrame(d.data, columns=d.feature_names)
    df['name'] = c
    df = df.sort_index(axis=1)
    dfd = pandas.get_dummies(df)
    return df, dfd
