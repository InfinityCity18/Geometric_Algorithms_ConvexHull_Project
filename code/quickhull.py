def dist_to_line(l1, l2, p):
    res = abs((l2[1]-l1[1])*p[0] - (l2[0]-l1[0])*p[1] + l2[0]*l1[1] - l2[1]*l1[0])
    res /= sqrt((l2[1]-l1[1])**2 + (l2[0]-l1[0])**2)
    return
 
def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])
   
def quickhull(points):
    points = points.copy()
    top, bottom, left, right = points[0], points[0], points[0], points[0]
    for p in points:
        if p[0] < left[0]: left = p
        if p[0] > right[0]: right = p
        if p[1] < bottom[1]: bottom = p
        if p[1] > top[1]: top = p
    new_points = []
    for p in points:
        if p in (top, bottom, left, right): continue
        if  det(left, top, p) > 0 or det(top, right, p) > 0 or det(right, bottom, p) > 0 or det(bottom, left, p) > 0:
            new_points.append(p)
    print(len(points))
    print(len(new_points))
from tests import *
quickhull(generate_uniform_points(10,-10,10))


