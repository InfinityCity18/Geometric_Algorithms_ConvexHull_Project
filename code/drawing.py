import matplotlib.pyplot as plt
def draw_points(points):
    x, y = zip(*points)
    plt.figure(figsize=(6,6))
    plt.xlabel("x")
    plt.ylabel("y")
    plt.scatter(x, y)
    plt.show()

def draw_hull(points,hull):
    x, y = zip(*points)
    hull.append(hull[0])
    xh, yh = zip(*hull)
    plt.figure(figsize=(6,6))
    plt.xlabel("x")
    plt.ylabel("y")
    plt.scatter(x, y)
    plt.scatter(xh, yh,color ="red",s=50)
    plt.plot(xh,yh,color="red")
    plt.show()


