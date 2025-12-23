eps = 10**-12

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])
#literally to co z wiki (nwm co tu jest źle)
#czasem coś jest źle (zwykle off by 1)
#do poprawy
def incremental(points):
    s_points = sorted(points, key = lambda p: (p[0], p[1]))
    hull = [s_points[0], s_points[1]]
    
    for i in range(2, len(s_points)):
        p = s_points[i]
        n = len(hull)
        
        upper_i = n-1
        lower_i = n-1
        while det(p, hull[upper_i%n], hull[(upper_i+1)%n]) <= -eps:
            upper_i +=1
        while det(p, hull[lower_i%n], hull[(lower_i-1)%n]) >= eps:
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

 
