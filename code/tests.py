import numpy as np
from drawing import draw_points, draw_hull

np.random.seed(19)

def generate_uniform_points(left=-100, right=100, n=100):
    return [(np.random.uniform(left, right), np.random.uniform(left, right)) for _ in range(n)]

def generate_circle_points(O, R, n=100):
    points = []
    for i in range(n):
        angle = np.random.uniform(0, 2*np.pi)
        points.append((O[0] + R * np.sin(angle), O[1] + R * np.cos(angle)))
    return points

testset = generate_uniform_points(-10,10,100)
from graham import *
from jarvis import *
from monochain import *
from quickhull import *
from divide_and_conquer import *
from chan import *
print("convex hull points jarvis: ", len(jarvis(testset)))
draw_hull(testset, jarvis(testset))
draw_hull(testset, quickhull(testset))
print("convex hull points graham: ", len(graham(testset)))
print("convex hull points monochain: ", len(monochain(testset)))
print("convex hull points quickhull: ", len(quickhull(testset)))
print("convex hull points divide and conquer: ", len(divide_and_conquer(testset)))
print("convex hull points chan:", len(chan(testset)))
