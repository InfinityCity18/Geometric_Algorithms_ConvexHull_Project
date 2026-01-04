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
    res = [left] 
    res += rec_hull(left,bottom, new_points) 
    if bottom != left: res += [bottom]
    res += rec_hull(bottom,right,new_points)
    if right != bottom: res += [right]
    res += rec_hull(right,top,new_points)
    if top != right and top != left: res += [top] 
    res += rec_hull(top,left,new_points)

    return res


def quickhull_vis(points, title="Quickhull", path=None):
    from drawing import Visualizer
    from collections import defaultdict
    viz = Visualizer(f"{title} n = {len(points)}")
    viz.auto_set_bounds(points)
    viz.add_permament([("points", "darkgray", points.copy())])

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


    line_frames = defaultdict(list)
    lines_done = defaultdict(list)
    def rec_hull(l1, l2, P, side, depth=0):
        nonlocal line_frames
        line_frames[(side,depth)].append((l1,l2))
        new_points = [p for p in P if det(l1,l2,p) < -eps]
        if not new_points:
            lines_done[(side,depth)].append((l1,l2))
            return []
        farthest = max(new_points, key = lambda p: dist_to_line(l1,l2,p))
        return rec_hull(l1,farthest,new_points,side,depth+1) + [farthest] + rec_hull(farthest,l2,new_points,side,depth+1) 

    res = [left] 
    res += rec_hull(left,bottom, new_points,0) 
    if bottom != left: res += [bottom]
    res += rec_hull(bottom,right,new_points,1)
    if right != bottom: res += [right]
    res += rec_hull(right,top,new_points,2)
    if top != right and top != left: res += [top] 
    res += rec_hull(top,left,new_points,3)

    hull_data = []
    num_frames = 2
    lines_sides = [[(left,bottom)],[(bottom,right)],[(right,top)],[(top,left)]]
    for (side, depth), line_data in sorted(line_frames.items(), key = lambda x: x[0]):
        lines_sides[side] = line_data
        viz.add_frame([("lines", "blue", sum(lines_sides,[])), ("lines", "red", hull_data.copy())])
        hull_data += lines_done[(side,depth)]
        num_frames += 1

    pts = set()
    for l in hull_data:
        pts.add(l[0])
        pts.add(l[1])
    viz.add_frame([("lines", "red", hull_data), ("points", "red", pts, 4)])
    viz.draw_animation(10000/num_frames, path)
