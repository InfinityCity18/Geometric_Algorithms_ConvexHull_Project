from collections import deque
from numpy import atan2
eps = 10**-12

def dist(p1,p2):
    return (p1[0] - p2[0])**2 + (p1[1]-p2[1])**2

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])

def graham(points):
    points = points.copy()

    #znajdowanie najniższego punktu
    lowest_point = points[0]
    for p in points:
        if p[1] == lowest_point[1] and p[0] < lowest_point[0]: lowest_point = p
        elif p[1] < lowest_point[1]: lowest_point = p
    points.remove(lowest_point)
    
    #sortowanie punktów 
    points.sort(key=lambda p: (atan2(p[1] - lowest_point[1], p[0] - lowest_point[0]),
                               dist(p,lowest_point))) 

    #usuwanie punktów współliniowych
    temp_points = []
    n = len(points)
    i = 0
    while i < n:
        j = i
        while j + 1 < n and abs(det(lowest_point, points[j], points[j+1])) <= eps:
                   j += 1
        temp_points.append(points[j])
        i = j + 1

    points = temp_points

    #główna pętla
    hull = [lowest_point]
    for p in points:
        while len(hull) >= 2 and det(hull[-2], hull[-1], p) <= eps:
            hull.pop()
        hull.append(p)
    
    return hull


def graham_vis(points,title ="Graham",path=None):
    from drawing import Visualizer
    viz = Visualizer(f"{title} n = {len(points)}")
    viz.auto_set_bounds(points)
    viz.add_permament([("points", "gray", points)])
    num_frames = 0


    points = points.copy()
    lowest_point = points[0]
    for p in points:
        if p[1] == lowest_point[1] and p[0] < lowest_point[0]: lowest_point = p
        elif p[1] < lowest_point[1]: lowest_point = p
    points.remove(lowest_point)
    
    points.sort(key=lambda p: (atan2(p[1] - lowest_point[1], p[0] - lowest_point[0]),
                               dist(p,lowest_point))) 
    temp_points = []
    n = len(points)
    i = 0
    while i < n:
        j = i
        while j + 1 < n and abs(det(lowest_point, points[j], points[j+1])) <= eps:
                   j += 1
        temp_points.append(points[j])
        i = j + 1

    points = temp_points

    hull = [lowest_point]
    
    def snap(current):
        nonlocal num_frames
        num_frames+=1
        frame = []
        frame.append(("polygon_open", "red", hull.copy()))
        if(current): frame[0][2].append(current)
        viz.add_frame(frame)
    snap(None)
    for p in points:
        while len(hull) >= 2 and det(hull[-2], hull[-1], p) <= eps:
            hull.pop()
            snap(p)
        hull.append(p)
        snap(None)

    viz.add_frame([("polygon", "red", hull.copy()), ("points", "red", hull.copy(), 4)])
    viz.draw_animation(10000/num_frames, path)    
