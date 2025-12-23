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

