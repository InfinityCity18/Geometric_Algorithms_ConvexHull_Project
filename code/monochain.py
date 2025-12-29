eps = 10**-12

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])

def monochain(points):
    s_points = sorted(points, key = lambda p: (p[0], p[1]))
    upper_hull = [s_points[0], s_points[1]]
    for i in range(2, len(s_points)):
        p = s_points[i]
        while len(upper_hull) > 1 and det(upper_hull[-2], upper_hull[-1], p) < -eps:
            upper_hull.pop()
        upper_hull.append(p)
    
    lower_hull = [s_points[0], s_points[1]]
    for i in range(2, len(s_points)):
        p = s_points[i]
        while len(lower_hull) > 1 and det(lower_hull[-2], lower_hull[-1], p) > eps:
            lower_hull.pop()
        lower_hull.append(p)

    result = lower_hull.copy()
    for i in range(len(upper_hull) - 2, 0, -1):
        result.append(upper_hull[i])
    return result

def monochain_vis(points,title="Monochain",path=None):
    from drawing import Visualizer
    viz = Visualizer(f"{title} n = {len(points)}")
    viz.auto_set_bounds(points)
    viz.add_permament([("points", "darkgray", points.copy())])
    num_frames = 0

    
    s_points = sorted(points, key = lambda p: (p[0], p[1]))
    upper_hull = [s_points[0], s_points[1]]
    lower_hull = [s_points[0], s_points[1]]
    
    def snap(p_lower, p_upper):
        nonlocal num_frames
        num_frames += 1
        frame = []
        frame.append(("polygon_open", "blue", lower_hull.copy()))
        frame.append(("polygon_open", "pink", upper_hull.copy()))
        if p_lower: frame[0][2].append(p_lower)
        if p_upper: frame[1][2].append(p_upper)
        viz.add_frame(frame)
        
    for i in range(2, len(s_points)):
        p = s_points[i]
        while len(upper_hull) > 1 and det(upper_hull[-2], upper_hull[-1], p) < -eps:
            upper_hull.pop()
            snap(None, p)
        upper_hull.append(p)
        snap(None, None)
    
    
    for i in range(2, len(s_points)):
        p = s_points[i]
        while len(lower_hull) > 1 and det(lower_hull[-2], lower_hull[-1], p) > eps:
            lower_hull.pop()
            snap(p,None)
        lower_hull.append(p)
        snap(None,None)

    result = lower_hull.copy()
    for i in range(len(upper_hull) - 2, 0, -1):
        result.append(upper_hull[i])
    viz.add_frame([("polygon", "red", result)])
    viz.draw_animation(10000/num_frames,path)

