import numpy as np
from drawing import draw_points, draw_hull

np.random.seed(13)

def generate_uniform_points(left=-100, right=100, n=100):
    return [(np.random.uniform(left, right), np.random.uniform(left, right)) for _ in range(n)]

def generate_circle_points(O=(0,0), R=10, n=100):
    points = []
    for i in range(n):
        angle = np.random.uniform(0, 2*np.pi)
        points.append((O[0] + R * np.sin(angle), O[1] + R * np.cos(angle)))
    return points

def generate_zigzag_points(width=10, height=10, n=100, amplitude=5, period=5):
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

testset = generate_uniform_points(-10,10,100)
#testset = generate_zigzag_points(100,100,0,10,10)
from graham import *
from jarvis import *
from monochain import *
from quickhull import *
from divide_and_conquer import *
from chan import *
from incremental import *
print("convex hull points jarvis: ", len(jarvis(testset)))
print("convex hull points graham: ", len(graham(testset)))
print("convex hull points incremental: ", len(incremental(testset)))
print("convex hull points monochain: ", len(monochain(testset)))
print("convex hull points quickhull: ", len(quickhull(testset)))
print("convex hull points divide and conquer: ", len(divide_and_conquer(testset)))

quickhull_vis(testset)
graham_vis(testset)
jarvis_vis(testset)
monochain_vis(testset)
divide_and_conquer_vis(testset)
incremental_vis(testset)
