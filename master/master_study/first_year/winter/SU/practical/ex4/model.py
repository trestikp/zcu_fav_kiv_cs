import numpy as np


class LinearRegression:

    def __init__(self, x_dim):
        self.theta = np.zeros(x_dim)
        self.cost_history = []
        self.theta_history = []

    def predict(self, X):
        """
        Computes the prediction (hzpothesis) of the linear regression
        :param X: input data as row vectors
        :return: vector of predicted outputs
        """
        return np.dot(X, self.theta)

    def cost(self, X, y):
        """
        Computes the loss function of a linear regression (mean square error)
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return: Loss value
        """
        h = self.predict(X)
        return (1 / (2 * len(X))) * sum((h - y) ** 2) # lecture cost function - same results (why the sum)?
        # return (1 / (2 * len(X))) * np.matmul(np.transpose(h - y), (h - y))

    def grad(self, X, y):
        """
        Computes the gradient of the loss function with regard to the parameters theta
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return: Gradient
        """
        h = self.predict(X)
        # return (1 / (2 * len(X))) * np.matmul(np.transpose(X - y), (np.dot(X, self.theta) - y))
        return (1 / (2 * len(X))) * np.matmul(np.transpose(X - y), (h - y))

    def analytical_solution(self, X, y):
        """
        Computes analytical solution of the least-squares method (normal equation)
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return:
        """
        # theta = pinv((X') * X) * X' * y;
        # TODO: this solution doesn't seem right
        self.theta = np.dot(np.linalg.inv(np.dot(X.T, X)), np.dot(X.T, y))
        # self.theta = np.matmul(np.matmul(np.linalg.pinv(np.matmul(np.transpose(X), X)), np.transpose(X)), y)
        # return np.matmul(np.matmul(np.linalg.pinv(np.matmul(np.transpose(X), X)), np.transpose(X)), y)
