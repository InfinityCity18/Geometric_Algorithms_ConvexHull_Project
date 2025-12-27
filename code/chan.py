eps = 10**-12

from graham import graham
from itertools import batched

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])

def turn(p, q, r):
    """Returns -1, 0, 1 if p,q,r forms a right, straight, or left turn."""
    return det(p,q,r) > eps - det(p,q,r) < -eps


def rtangent(hull, p):
    TURN_LEFT, TURN_RIGHT = (1, -1)
    """Return the index of the point in hull that the right tangent line from p
    to hull touches.
    """
    #shamelessly ukradzione https://gist.github.com/tixxit/252229
    l, r = 0, len(hull)
    l_prev = turn(p, hull[0], hull[-1])
    l_next = turn(p, hull[0], hull[(l + 1) % r])
    while l < r:
        c = (l + r) / 2
        c_prev = turn(p, hull[c], hull[(c - 1) % len(hull)])
        c_next = turn(p, hull[c], hull[(c + 1) % len(hull)])
        c_side = turn(p, hull[l], hull[c])
        if c_prev != TURN_RIGHT and c_next != TURN_RIGHT:
            return c
        elif c_side == TURN_LEFT and (l_next == TURN_RIGHT or
                                      l_prev == l_next) or \
                c_side == TURN_RIGHT and c_prev == TURN_RIGHT:
            r = c               # Tangent touches left chain
        else:
            l = c + 1           # Tangent touches right chain
            l_prev = -c_next    # Switch sides
            l_next = turn(p, hull[l], hull[(l + 1) % len(hull)])
    return l

# def tangential_binsearch(hull, p0):
#     left, right = 0, len(hull)
#     while left < right:
#         mid = (left + right) // 2
#         if det(p0, hull[mid], hull[(mid + 1) % len(hull)]) > 0:
#             right = mid
#         else:
#             left = mid + 1
#     return hull[left % len(hull)]

def step_chan(points, m):
    n = len(points)
    hulls = list(map(graham, batched(points, n=m))) #dzielimy na n / m otoczek, aplikujemy grahama na kazda
    # zakladam ze otoczka grahama dziala poprawnie na 1,2,3 punkty 

    p1 = max(points, key=lambda p: (p[0], p[1])) #najbardziej na prawo
    p0 = (p1[0] + 1.0, p1[1]) 
    #ogolnie to jest aby wybrac punkt w nieskonczonosci, ale tu jest + 1.0 w prawo, idk jak poprawic bo to moze sie popsuc przez precyzje floatow
    #nie chcialo mi sie myslec nad tym az tyle xd wiec do poprawy
    final_hull = [p1]

    for j in range(m):
        best = points[0] if points[0] != p1 else points[1] #chyba pasi aby pierwszy lepszy punkt xd
        for i in range(len(hulls)):
            pass
            #q = maximized_angle #u trzeba znalezc w hull[i] najlepszy punkt dla hulla ale nie wiem jak to zrobic w log czasie, binsearch? nie widze na razie tego i ide spac xd
            #d = det(p0,)




