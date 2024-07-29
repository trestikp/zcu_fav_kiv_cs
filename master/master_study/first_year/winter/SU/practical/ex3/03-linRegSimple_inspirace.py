import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from mpl_toolkits.mplot3d import axes3d, Axes3D
from matplotlib import cm
from scipy.stats import linregress

class LinearRegression:
    def __init__(self):
        self.theta = np.array([0., 0.])

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
        computedCost = (1 / (2*len(X))) * sum((h - y)**2)

        self.cost_history.append(computedCost)

        return computedCost

    def train(self, X, y, lr, k, epsilon=None):
        """
        Trains the linear regression model (finds optimal parameters)
        :param X: input data as row vectors
        :param y: vector of the expected outputs
        :param lr: learning rate
        :param k: number of steps
        :param epsilon:
        :return:
        """
        
        for x in range(k):
            h = self.predict(X)
            
            t_1 = self.theta[0] - lr * (1 / len(y)) * sum(h - y)
            t_2 = self.theta[1] - lr * (1 / len(y)) * sum((h - y) * X[:, 1])

            self.theta = np.array([t_1, t_2])
            self.theta_history.append(self.theta)

            self.cost(X, y)
        pass



def load_data(fn):
    """
    Loads the data for the assignment
    :param fn: file path
    :return: tuple: (input coordinates as the matrix of row vectors of the data, where each vector is in the form: [1, x],
                    expected outputs)
    """
    x_ = []
    y_ = []

    with open(fn, 'r') as f:
        for line in f:
            x, y = line.split(",")
            x_.append(float(x))
            y_.append(float(y))

    return np.stack([np.ones(len(x_)), np.array(x_)], axis=1), np.array(y_)

def plot_data(X, y):
    """
    Plots the data into a coordinates system.
    :param X:
    :param y:
    :return:
    """
    plt.figure()
    plt.scatter(X[:,1], y, marker="x", color='red')
    plt.xlabel("City population (×1e5)")
    plt.ylabel("Profit (×1e5 $)")
    plt.savefig("data.pdf")
    plt.show()

def plot_regression(model, X, y):
    """
    Plots the data with the regression line.
    :param model: Linear regression model
    :param X: inputs
    :param y: expected outputs
    :return:
    """
    plt.figure()
    plt.scatter(X[:,1], y, marker="x", color='red')
    x1 = np.min(X, axis=0)
    x2 = np.max(X, axis=0)
    y1 = model.predict(x1)
    y2 = model.predict(x2)
    plt.plot([x1[1], x2[1]], [y1, y2], color='blue')
    plt.legend(["Training data", "Linear regression"])
    plt.xlabel("City population (×1e5)")
    plt.ylabel("Profit (×1e5 $)")
    plt.savefig("regression.pdf")
    plt.show()


def plot_cost(model, X, Y):
    """
    Plots the loss value according to changing theta parameters
    :param model: Linear regression model
    :param X: input data as row vectors
    :param y: vector of the expected outputs
    :return:
    """
    dummy_model = LinearRegression()
    a1 = -2
    a2 = 4
    b1 = -30
    b2 = 30

    a_space = np.linspace(a1 - 1, a2 + 1)
    b_space = np.linspace(b1 - 1, b2 + 1)

    A, B = np.meshgrid(a_space, b_space)
    Z = np.zeros_like(A)
    for i, a in enumerate(a_space):
        for j, b in enumerate(b_space):
            dummy_model.theta = np.array([b, a])
            Z[j, i] = dummy_model.cost(X, Y)

    plt.figure()
    plt.contour(A, B, Z, levels=30)
    plt.xlim((a1 - 1, a2 + 1))
    plt.ylim((b1 - 1, b2 + 1))
    
    
    for i in range(len(model.theta_history)):
        plt.plot(model.theta_history[i][1], model.theta_history[i][0], marker="o", markersize=1, markeredgecolor="red", markerfacecolor="red")

    plt.plot(model.theta[1], model.theta[0], marker="x", markersize=10, markeredgecolor="blue", markerfacecolor="blue")

    plt.savefig("cost.pdf")
    plt.show()

def normalEque(X, y):   
    theta = np.linalg.pinv(X).dot(y)
    return theta

def plot_surf(X, y):
    """
    3d plot of the surface of the loss with regard to parameters theta
    :param X: input data as row vectors
    :param y: vector of the expected outputs
    :return:
    """
    model = LinearRegression()
    theta0_vals = np.linspace(-10, 10, 100)
    theta1_vals = np.linspace(-10, 10, 100)
    Theta1, Theta0 = np.meshgrid(theta1_vals, theta0_vals)
    J_vals = np.zeros_like(Theta1)
    for i in range(len(theta1_vals)):
        for j in range(len(theta0_vals)):
            model.theta = [theta0_vals[j], theta1_vals[i]]
            J_vals[i][j] = model.cost(X, y)

    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.plot_surface(Theta1, Theta0, J_vals, cmap=cm.coolwarm)

    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    
    plt.savefig("convergence3d.pdf")
    plt.show()

if __name__ == '__main__':
    steps = 2000
    X_, y_ = load_data("data.txt")

    plot_data(X_, y_)

    lin_reg = LinearRegression()
    alpha = 0.024
    lin_reg.train(X_, y_, alpha, steps)
    print("Theta found by gradient descent: " + str(lin_reg.theta))

    predict1 = lin_reg.predict(np.array([1, 3.5]))
    print(f'For population = 35,000, we predict a profit of {predict1*10000}')
    predict2 = lin_reg.predict(np.array([1, 7]))
    print(f'For population = 70,000, we predict a profit of {predict2*10000}')

    plot_regression(lin_reg, X_, y_)
    plot_surf(X_, y_)
    plot_cost(lin_reg, X_, y_)
    print("Normal equation theta: " + str(normalEque(X_, y_)))

    # Calculate the cost using the theta found by equation
    lin_reg = LinearRegression()
    lin_reg.theta = normalEque(X_, y_)
    cost = lin_reg.cost(X_, y_)
    
    costLineArray = np.empty(steps)
    costLineArray.fill(cost)

    print("Normal equation theta cost: " + str(cost))

    # Print multiple plots
    figure, axis = plt.subplots(2, 2)

    lin_reg = LinearRegression()
    lin_reg.train(X_, y_, 0.0001, steps)
    axis[0, 0].plot(np.arange(0, steps), lin_reg.cost_history)
    axis[0, 0].plot(np.arange(0, steps), costLineArray, linestyle='dashed', color='green')
    axis[0, 0].set_title("Alpha: 0.0001")

    lin_reg = LinearRegression()
    lin_reg.train(X_, y_, 0.001, steps)
    axis[0, 1].plot(np.arange(0, steps), lin_reg.cost_history)
    axis[0, 1].plot(np.arange(0, steps), costLineArray, linestyle='dashed', color='green')
    axis[0, 1].set_title("Alpha: 0.001")

    lin_reg = LinearRegression()
    lin_reg.train(X_, y_, 0.01, steps)
    axis[1, 0].plot(np.arange(0, steps), lin_reg.cost_history)
    axis[1, 0].plot(np.arange(0, steps), costLineArray, linestyle='dashed', color='green')
    axis[1, 0].set_title("Alpha: 0.01")

    lin_reg = LinearRegression()
    lin_reg.train(X_, y_, 0.024, steps)
    axis[1, 1].plot(np.arange(0, steps), lin_reg.cost_history)
    axis[1, 1].plot(np.arange(0, steps), costLineArray, linestyle='dashed', color='green')
    axis[1, 1].set_title("Alpha: 0.024")

    plt.savefig("multipleAlphaValues.pdf")
    plt.show()
