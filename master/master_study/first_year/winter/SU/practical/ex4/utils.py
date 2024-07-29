import numpy as np
from collections import defaultdict


def normalize_features(X):
    """
    Normalizes features to zero mean and unit variance
    :param X: input data
    :return: normalized data, original means, and standard deviations
    """
    X_norm = np.copy(X)
    dims = X.shape[1]
    mu = np.zeros(dims)
    sigma = np.zeros(dims)

    for i in range(dims):
        mu[i] = np.mean(X[:, i])
        sigma[i] = np.std(X[:, i])

    X_norm = (X - mu) / sigma

    return X_norm, mu, sigma


def normalize_input(X, mu, sigma):
    """
    Normalizes input X using mu and sigma calculated while training the algorithm
    :param X: input to be normalized
    :param mu: calculated means in training phase
    :param sigma: calculated sigmas in training phase
    :return X_norm = normalized data
    """
    X_norm = np.copy(X)
    X_norm = (X - mu) / sigma

    return X_norm


def build_dict(data):
    """
    Creates dictionary for dictionary feature transform (training phase)
    :param data: list (1D array) of input strings
    :return: the dictionary
    """
    dict = []
    for record in data:
        if record not in dict:
            dict.append(record)

    return dict
    # return np.array(dict)


def transform(dict, string_list):
    """
    Transforms the input strings into one-hot vectors
    :param dict: dictionary from the training phase
    :param string_list: list (1D array) of input strings
    :return: a matrix of one-hot row vectors
    """
    matrix = np.zeros((len(string_list), len(dict) + 1))

    for i, rec in enumerate(string_list):
        try:
            idx = dict.index(rec)
            matrix[i, idx + 1] = 1
        except ValueError:
            matrix[i, 0] = 1 # on error sets first index (first column = error)

    return matrix


def cross_validation(X, y, k, opt_gen, model_gen):
    """
    Performs k-fold cross-validation
    :param X: input data as row vectors
    :param y: vector of the expected outputs
    :param k: number of folds
    :param opt_gen: function which creates an optimizer (with the model as a parameter)
    :param model_gen: function which creates a model
    :return: test predicted values for whole dataset
    """
    y_pred = np.zeros_like(y)
    step = int(X.shape[0] / k)
    for i in range(k):
        test_min = i * step
        test_max = np.minimum((i + 1) * step, X.shape[0])
        X_train = np.concatenate([X[:test_min, :], X[test_max:, :]], axis=0)
        y_train = np.concatenate([y[:test_min], y[test_max:]], axis=0)
        X_test = X[test_min: test_max, :]
        model = model_gen()
        opt = opt_gen(model)
        opt.optimize_full_batch(X_train, y_train)
        y_pred[i * step: (i + 1) * step] = model.predict(X_test)
    return y_pred


def add_one(X):
    if len(X.shape) == 1:
        X = np.expand_dims(X, axis=0)
    return np.concatenate([np.ones([X.shape[0], 1]), X], axis=1)
