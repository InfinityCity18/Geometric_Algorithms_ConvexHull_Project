from itertools import groupby
eps = 10**-12

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])


def x_sort(points):
    points.sort()
    res = []
    for x, pts in groupby(points, key=lambda p: p[0]):
        pts = list(pts)
        res.append(pts[0])
        if len(pts) > 1 and pts[-1] != pts[0]:
            res.append(pts[-1])
    return res

def incremental(points):
    s_points = x_sort(points)
    hull = [s_points[0], s_points[1]]
    
    for i in range(2, len(s_points)):
        p = s_points[i]
        n = len(hull)
        
        upper_i = n-1
        lower_i = n-1
        while det(p, hull[upper_i%n], hull[(upper_i+1)%n]) <= eps:
            upper_i +=1
        while det(p, hull[lower_i%n], hull[(lower_i-1)%n]) >= -eps:
            lower_i -=1
        
        new_hull = []
        j = upper_i
        while j%n != lower_i%n:
            new_hull.append(hull[j%n])
            j += 1
        new_hull.append(hull[lower_i%n])
        new_hull.append(p)
        hull = new_hull.copy()

    return hull

def incremental_vis(points, title="Incremental", path=None):
    from drawing import Visualizer
    viz = Visualizer(f"{title} n = {len(points)}")
    viz.auto_set_bounds(points)
    viz.add_permament([("points", "gray", points)])
    num_frames = 0


    s_points = x_sort(points)
    hull = [s_points[0], s_points[1]]
    
    def snap(new_part=None):
        nonlocal num_frames
        num_frames += 1
        frame = []
        frame.append(("polygon", "red", hull.copy()))
        if new_part:
            frame.append(("lines", "blue", [(new_part[0], new_part[1]), (new_part[1], new_part[2])]))
        viz.add_frame(frame)
    snap()
    for i in range(2, len(s_points)):
        p = s_points[i]
        n = len(hull)
        
        upper_i = n-1
        lower_i = n-1
        while det(p, hull[upper_i%n], hull[(upper_i+1)%n]) <= eps:
            upper_i +=1
        while det(p, hull[lower_i%n], hull[(lower_i-1)%n]) >= -eps:
            lower_i -=1
        
        new_hull = []
        j = upper_i
        while j%n != lower_i%n:
            new_hull.append(hull[j%n])
            j += 1

        new_hull.append(hull[lower_i%n])
        new_hull.append(p)
        snap((hull[lower_i%n], p, hull[upper_i%n]))
        hull = new_hull.copy()
        snap()
    viz.add_frame([("polygon", "red", hull.copy())])
    num_frames+=1
    viz.draw_animation(10000/num_frames) 
