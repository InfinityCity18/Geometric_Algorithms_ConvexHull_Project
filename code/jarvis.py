from collections import deque
from numpy import atan2
eps = 10**-12

def dist(p1,p2):
    return (p1[0] - p2[0])**2 + (p1[1]-p2[1])**2

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])

def jarvis(points):
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

