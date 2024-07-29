import numpy as np
import matplotlib.pyplot as plt
import math


def calc_circumcenter():
    a = points[0]
    b = points[1]
    c = points[2]
    d = 2 * (a[0] * (b[1] - c[1]) + b[0] * (c[1] - a[1]) + c[0] * (a[1] - b[1]))
    x = (1 / d) * ((a[0] ** 2 + a[1] ** 2) * (b[1] - c[1]) + 
                   (b[0] ** 2 + b[1] ** 2) * (c[1] - a[1]) + 
                   (c[0] ** 2 + c[1] ** 2) * (a[1] - b[1]))
    y = (1 / d) * ((a[0] ** 2 + a[1] ** 2) * (c[0] - b[0]) + 
                   (b[0] ** 2 + b[1] ** 2) * (a[0] - c[0]) + 
                   (c[0] ** 2 + c[1] ** 2) * (b[0] - a[0]))
    return [x, y]

def calc_circumradius():
    a = np.linalg.norm(points[1] - points[2])
    b = np.linalg.norm(points[0] - points[2])
    c = np.linalg.norm(points[0] - points[1])
    r = (a * b * c) / (np.sqrt((a ** 2 + b ** 2 + c ** 2) ** 2 - (2 * (a ** 4 + b ** 4 + c ** 4))))
    return r

def draw_triangle():
    # construct points with the first point repeating to close the triangle
    closed_points =  np.reshape(np.append(points, points[0]), (-1, 2))
    X = closed_points[:, 0]
    Y = closed_points[:, 1]
    plt.plot(X, Y)

def draw_circumcircle():
    coords = calc_circumcenter()
    radius = calc_circumradius()

    circle = plt.Circle((coords[0], coords[1]), radius, fill=False)
    plt.gca().add_patch(circle)

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

if __name__ == "__main__":
    print("Input points in format \"1, 2\"")
    p1 = input_point(1)
    p2 = input_point(2)
    p3 = input_point(3)

    points = np.array([p1, p2, p3])

    draw_triangle()
    draw_circumcircle()
    plt.show()