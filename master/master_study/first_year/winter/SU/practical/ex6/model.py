import numpy as np


class LinearRegression:

    def __init__(self, x_dim):
        self.theta = np.zeros(x_dim)
        self.cost_history = []
        self.theta_history = []

    def predict(self, X):
        """
        Computes the prediction (hypothesis) of the linear regression
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
        return (1 / (2 * len(X))) * sum((h - y) ** 2) # lecture cost function

    def grad(self, X, y):
        """
        Computes the gradient of the loss function with regard to the parameters theta
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return: Gradient
        """
        h = self.predict(X)
        # return (1 / (2 * len(X))) * np.matmul(np.transpose(X - y), (np.dot(X, self.theta) - y))
        # return (1 / (2 * len(X))) * np.matmul(np.transpose(X), (h - y))
        return (1 / len(X)) * np.matmul(X.T, (h - y))

    def analytical_solution(self, X, y):
        """
        Computes analytical solution of the least-squares method (normal equation)
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return:
        """
        self.theta = np.dot(np.linalg.pinv(np.dot(X.T, X)), np.dot(X.T, y))


class LogisticRegression:

    def __init__(self, x_dim):
        self.theta = np.zeros(x_dim)
        self.cost_history = []
        self.theta_history = []

    def predict(self, X):
        """
        Computes the prediction (hypothesis) of the linear regression
        :param X: input data as row vectors
        :return: vector of predicted outputs
        """
        p = [0] * np.size(X, 0)
        s = self.get_positive_score(X)
        for i in range(np.size(X, 0)):
            if s[i] >= 0.5:
                p[i] = 1

        return p

    def get_positive_score(self, X):
        """
        Computes the probability of classification to the positive class
        :param X: Input data
        :return:
        """
        e = X * np.matrix(self.theta).T
        return 1 / (1 + np.exp(-e))

    def cost(self, X, y):
        """
        Computes the loss function of a linear regression (mean square error)
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return: Loss value
        """
        h = self.get_positive_score(X)

        cost = (-1 / np.size(y)) * np.sum(y * np.log(h) + (1 - y) * (np.log(1 - h)))
        return cost

    def grad(self, X, y):
        """
        Computes the gradient of the loss function with regard to the parameters theta
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return: Gradient
        """
        h = np.array(self.get_positive_score(X))[:, 0]

        grad = ((1 / len(X)) * np.matmul(X.T, (h - y)))
        return grad

    def update(self, theta, cost):
        # print("%s : grad = %s, cost = %s" % (str(self.theta), str(G), str(self.__cost)))
        self.theta = theta
        self.theta_history.append(np.copy(self.theta))
        self.cost_history.append(cost)