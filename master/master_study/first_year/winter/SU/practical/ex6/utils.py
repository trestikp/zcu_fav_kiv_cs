import numpy as np
from collections import defaultdict

import utils


def normalize_features(X):
    """
    Normalizes features to zero mean and unit variance
    :param X: input data
    :return: normalized data, original means, and standard deviations
    """
    u = np.mean(X, axis=0)
    s = np.std(X, axis=0)
    return (X - u) / s, u, s


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


def learning_curve(XtrainOrig, ytrainOrig, Xval, yval, model, train_func):
    error_train = []
    error_val = []

    X_orig = utils.add_one(XtrainOrig)
    X_vals = utils.add_one(Xval)

    # DAFUQ jak tu mam dostat dimenzi 11??
    m = np.size(XtrainOrig, 0) - 1

    for i in range(m):
        X_tmp = X_orig[:(i + 1), :]
        y_tmp = ytrainOrig[:(i + 1)]

        train_func(X_tmp, y_tmp)

        error_val.append(model.cost(X_vals, yval))
        error_train.append(model.cost(X_tmp, y_tmp))

    return error_train, error_val


def validation_curve(X, y, Xval, yval, model, train_func, lambda_vec):
    error_train = []
    error_val = []

    for i in range(len(lambda_vec)):
        X_tmp = X[:(i + 1), :]
        y_tmp = y[:(i + 1)]

        # TODO: set the alpha (or learning rate if it isnt the same..) according to lambda_vec - regularization has gradientOptions but it isn't used
        train_func(X_tmp, y_tmp)

        # TODO: set lambda to 0? why
        error_val.append(model.cost(Xval, yval))
        error_train.append(model.cost(X_tmp, y_tmp))

    return error_train, error_val
