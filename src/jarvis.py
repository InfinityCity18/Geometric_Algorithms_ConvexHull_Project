from collections import deque
from numpy import atan2
eps = 10**-12

def dist(p1,p2):
    return (p1[0] - p2[0])**2 + (p1[1]-p2[1])**2

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])

def jarvis(points):
    points = points.copy()
    n = len(points)
    lowest_point = points[0]
    for p in points:
        if p[1] == lowest_point[1] and p[0] < lowest_point[0]: lowest_point = p
        elif p[1] < lowest_point[1]: lowest_point = p

    convex_hull = []
    last = lowest_point

    while True:
        convex_hull.append(last)
        best = points[0] if points[0] != last else points[1]
        for p in points:
            if p == last:
                continue
            d = det(last,best,p)
            if d < -eps or (d < eps and dist(last,best) < dist(last,p)):
                best = p
        last = best
        if last == lowest_point:
            break

    return convex_hull

def jarvis_vis(points, title="Jarvis",path=None):
    from src.drawing import Visualizer
    viz = Visualizer(f"{title} n = {len(points)}")
    viz.auto_set_bounds(points)
    viz.add_permament([("points", "darkgray", points.copy())])
    num_frames = 0

    points = points.copy()
    n = len(points)
    lowest_point = points[0]
    for p in points:
        if p[1] == lowest_point[1] and p[0] < lowest_point[0]: lowest_point = p
        elif p[1] < lowest_point[1]: lowest_point = p

    convex_hull = []
    last = lowest_point
    def snap(best, current):
        nonlocal num_frames
        num_frames += 1 
        frame = []
        frame.append(("polygon_open", "red", convex_hull.copy() + [best]))
        frame.append(("lines", "blue", [(convex_hull[-1], current)]))
        viz.add_frame(frame)

    while True:
        convex_hull.append(last)
        best = points[0] if points[0] != last else points[1]
        for p in points:
            if p == last:
                continue
            d = det(last,best,p)
            if d < -eps or (d < eps and dist(last,best) < dist(last,p)):
                best = p
            snap(best,p) 

        last = best
        if last == lowest_point:
            break
    
    viz.add_frame([("polygon", "red", convex_hull.copy()),("points", "red", convex_hull.copy(),4)]) 
    num_frames+=1
    viz.draw_animation(10000/num_frames,path)


