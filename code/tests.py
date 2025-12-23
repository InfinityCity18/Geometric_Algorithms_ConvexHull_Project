import numpy as np

def generate_uniform_points(left=-100, right=100, n=100):
    return [(np.random.uniform(left, right), np.random.uniform(left, right)) for _ in range(n)]

def generate_circle_points(O, R, n=100):
    points = []
    for i in range(n):
        angle = np.random.uniform(0, 2*np.pi)
        points.append((O[0] + R * np.sin(angle), O[1] + R * np.cos(angle)))
    return points

testset = generate_uniform_points(-10,10,10)
import jarvis as j
import graham as g

print("convex hull points jarvis: ", len(j.jarvis(testset)))
print("convex hull points graham: ", len(g.graham(testset)))
