eps = 10**-12

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])
 
def dist_to_line(l1, l2, p):
    return abs(det(l1,l2,p)) 
   
def quickhull(points):
    points = points.copy()
    left = min(points, key=lambda p: p[0])
    right = max(points, key=lambda p: p[0])
    bottom = min(points, key=lambda p: p[1])
    top = max(points, key=lambda p: p[1])

    new_points = []
    for p in points:
        if p in (top, bottom, left, right): continue
        if det(left, top, p) > eps or det(top, right, p) > eps or det(right, bottom, p) > eps or det(bottom, left, p) > eps:
            new_points.append(p)


    def rec_hull(l1,l2, P):
        new_points = [p for p in P if det(l1,l2,p) < -eps]
        if not new_points:
            return []
        farthest = max(new_points, key = lambda p: dist_to_line(l1,l2,p))
        return rec_hull(l1,farthest,new_points) + [farthest] + rec_hull(farthest,l2,new_points) 

    return [left] + rec_hull(left,bottom, new_points) + [bottom] + rec_hull(bottom,right,new_points) + [right] + rec_hull(right,top,new_points) + [top] + rec_hull(top,left,new_points)


