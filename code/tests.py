import numpy as np
from drawing import draw_points, draw_hull

np.random.seed(13)

def generate_uniform_points(left=-100, right=100, n=100):
    return [(np.random.uniform(left, right), np.random.uniform(left, right)) for _ in range(n)]

def generate_circle_points(O=(0,0), R=100, n=100):
    points = []
    for i in range(n):
        angle = np.random.uniform(0, 2*np.pi)
        points.append((O[0] + R * np.sin(angle), O[1] + R * np.cos(angle)))
    return points

def generate_zigzag_points(width=100, height=100, n=100, amplitude=10, period=10):
    points = [(np.random.uniform(-width, width), np.random.uniform(-height, height)) for _ in range(n)]
    n = 2 * width // period
    for i in range(n):
        x = -width + i * period
        y = -height + amplitude * ((-1) ** i)
        points.append((x, y))
    for i in range(n):
        x = -width + i * period
        y = height + amplitude * ((-1) ** i)
        points.append((x, y))
    n = 2 * height // period
    for i in range(n):
        x = -width + amplitude * ((-1) ** i)
        y = -height + i * period
        points.append((x, y))
    for i in range(n):
        x = width + amplitude * ((-1) ** i)
        y = -height + i * period
        points.append((x, y))
    return points

def get_generators():
    gens = []
    gens.append((generate_uniform_points, "Generuje losowe punkty o współrzędnych z zakresiu [-100,100]"))
    gens.append((generate_circle_points, "Generuje losowe punkty leżące na kole o promieniu 100"))
    gens.append((generate_zigzag_points, "Generuje losowe punkty wewnątrz kwadratowego obszaru, które otoczone są obramówką"))
    return gens
