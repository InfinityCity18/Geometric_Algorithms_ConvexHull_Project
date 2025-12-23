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

