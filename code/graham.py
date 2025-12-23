def graham(points):
    lowest_point = points[0]
    for p in points:
        if p[1] == lowest_point[1] and p[0] < lowest_point[0]: lowest_point = p
        elif p[1] < lowest_point[1]: lowest_point = p
    points.remove(lowest_point)
    
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

    hull = [lowest_point]


    #główna pętla
    hull = [lowest_point]
    for p in points:
        while len(hull) >= 2 and det(hull[-2], hull[-1], p) <= eps:
            hull.pop()
        hull.append(p)
    
    return hull


