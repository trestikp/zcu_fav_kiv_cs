import numpy as np
import matplotlib.pyplot as plt
import math


def draw_triangle():
    # construct points with the first point repeating to close the triangle
    closed_points =  np.reshape(np.append(points, points[0]), (-1, 2))
    X = closed_points[:, 0]
    Y = closed_points[:, 1]
    plt.plot(X, Y)

def parse_point(input):
    parts = input.split(',')
    
    if len(parts) != 2:
        return None
    
    try:
        return [int(parts[0]), int(parts[1])]
    except ValueError:
        return None

def input_point(point_number):
    while True:
        buf = input("Point " + str(point_number) + ": ")
        res = parse_point(buf)
        if res == None:
            print("Failed to parse point. Please input point again.")
        else:
            break
    return res

def y_from_x(x):
    # ax^2 + ay^2 + bxx + byy + c = 0
    # ay^2 + byy = -(ax^2 + bxx + c)
    # return np.sqrt((-((a * x ** 2) + bx * x + )))

if __name__ == "__main__":
    print("Input points in format \"1, 2\"")
    p1 = input_point(1)
    p2 = input_point(2)
    p3 = input_point(3)

    points = np.array([p1, p2, p3])

    A = np.array([[p1[0], p1[1], 1], 
                  [p2[0], p2[1], 1], 
                  [p3[0], p3[1], 1]])
    a = np.linalg.det(A)

    BX = np.array([[p1[0] ** 2 + p1[1] ** 2, p1[1], 1], 
                   [p2[0] ** 2 + p2[1] ** 2, p2[1], 1], 
                   [p3[0] ** 2 + p3[1] ** 2, p3[1], 1]])
    bx = -np.linalg.det(BX)

    BY = np.array([[p1[0] ** 2 + p1[1] ** 2, p1[0], 1], 
                   [p2[0] ** 2 + p2[1] ** 2, p2[0], 1], 
                   [p3[0] ** 2 + p3[1] ** 2, p3[0], 1]])
    by = np.linalg.det(BY)

    C = np.array([[p1[0] ** 2 + p1[1] ** 2, p1[0], p1[1]], 
                  [p2[0] ** 2 + p2[1] ** 2, p2[0], p2[1]], 
                  [p3[0] ** 2 + p3[1] ** 2, p3[0], p3[1]]])
    c = -np.linalg.det(C)

    center_x = -(bx / (2 * a))
    center_y = -(by / (2 * a))
    radius = np.sqrt(bx ** 2 + by ** 2 - 4 * a * c) / (2 * np.absolute(a))

    # circle = plt.Circle((center_x, center_y), radius, fill=False)
    # plt.gca().add_patch(circle)

    # ax2 + ay2 + bxx + byy + c = 0 => ay2 = -(ax2 + bxx + byy + c) => y = sqrt(-(-||-) / a)


    draw_triangle()
    plt.show()