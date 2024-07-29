import numpy as np


class Optimizer:

    def __init__(self, model):
        self.model = model
        self.iter = 0

    def step(self, X, y):
        """
        Performs a single step of the gradient descent
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return:
        """
        raise NotImplementedError("Method not yet implemented.")

    def converged(self):
        """

        :return: True if the gradient descent iteration ended
        """
        raise NotImplementedError("Method not yet implemented.")

    def optimize_full_batch(self, X, y):
        """
        Runs the optimization processing all the data at each step
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return:
        """
        while not self.converged():
            self.step(X, y)
            self.iter += 1


class GradientDescent(Optimizer):

    def __init__(self, model, alpha=0.0005, num_iters=1000, min_cost=0, min_theta_diff=0, **options):
        super(GradientDescent, self).__init__(model)
        self.options = options
        self.alpha = alpha
        self.num_iters = num_iters
        self.min_cost = min_cost
        self.min_theta_diff = min_theta_diff
        self.cost = np.Inf

    def step(self, X, y):
        """
        Performs a single step of the gradient descent
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :return:
        """
        h = self.model.predict(X)

        for idx, t in enumerate(self.model.theta):
            self.model.theta[idx] = self.model.theta[idx] - self.alpha * (1 / len(X)) * sum((h - y) * X[:, idx])

        self.model.cost_history.append(self.model.cost(X, y))
        self.model.theta_history.append(np.copy(self.model.theta))

    def converged(self):
        """

        :return: True if the gradient descent iteration ended
        """
        margins = False # cost and theta margin flag, if either cost or thetas are under entered margin

        if self.iter > 2:
            cost_diff = self.model.cost_history[-2] - self.model.cost_history[-1]
            theta_diff = self.model.theta_history[-2] - self.model.theta_history[-1]    
            thetas_within_margin = True
            for td in theta_diff:
                thetas_within_margin &= abs(td) < self.min_theta_diff
            margins = abs(cost_diff) < self.min_cost or thetas_within_margin

        # returns True if either number of iterations is reached or cost/ thetas are within margins
        return self.iter >= self.num_iters or margins