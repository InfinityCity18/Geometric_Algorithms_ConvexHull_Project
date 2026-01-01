from graham import graham
from itertools import batched

eps = 10**-12

def det(a, b, c):       
     return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])
    
def dist(p1,p2):
    return (p1[0] - p2[0])**2 + (p1[1]-p2[1])**2

def turn(p, q, r):
    a = (q[0] - p[0])*(r[1] - p[1]) - (r[0] - p[0])*(q[1] - p[1])
    if abs(a) < eps:
        return 0
    elif a > 0:
        return 1
    else:
        return -1
    # def cmp(a, b):
    #     return (a > b) - (a < b)
    # return cmp((q[0] - p[0])*(r[1] - p[1]) - (r[0] - p[0])*(q[1] - p[1]), eps)

def rtangent(hull, p):
    '''
    Zwraca punkt otoczki bedacy styczna prawostronna z punktu p
    
    :param hull: Otoczka wypukla w postaci listy punktow ukladzie przeciwnym do ruchu wskazowek zegara
    :param p: Punkt spoza otoczki
    '''

    #shamelessly ukradzione https://gist.github.com/tixxit/252229
    if len(hull) == 1:
        return hull[0]
    elif p in hull: #jesli p jest w otoczce to funkcja zwroci wlasnie ten punkt, czego nie chcemy
        hull = hull.copy() #kopiujemy bo nie chcemy modyfikowac oryginalnej otoczki
        hull.remove(p)
        if len(hull) == 1:
            return hull[0]

    TURN_LEFT, TURN_RIGHT, COLL = (1, -1, 0)
    n = len(hull)
    l, r = 0, n - 1

    l_prev = turn(p, hull[0], hull[-1])
    l_next = turn(p, hull[0], hull[1])

    if l_next == 0:
        i = 0
        while turn(p, hull[i], hull[(i + 1) % n]) == 0 and dist(p, hull[(i+1) % n]) > dist(p, hull[i]): 
            i = (i + 1) % n
        return hull[i]

    while l <= r:
        c = (l + r) // 2

        c_prev = turn(p, hull[c], hull[(c - 1) % n])
        c_next = turn(p, hull[c], hull[(c + 1) % n])
        c_side = turn(p, hull[l], hull[c])

        if c_prev != TURN_RIGHT and c_next != TURN_RIGHT:
            i = c
            while turn(p, hull[i], hull[(i + 1) % n]) == 0:
                i = (i + 1) % n
            return hull[i]

        elif (c_side == TURN_LEFT and
            (l_next == TURN_RIGHT or l_prev == l_next)) or \
        (c_side == TURN_RIGHT and c_prev == TURN_RIGHT):
            r = c - 1
        else:
            l = c + 1
            if l < n:
                l_prev = -c_next
                l_next = turn(p, hull[l], hull[(l + 1) % n])

    return hull[l % n]

def step_chan(points, m):
    n = len(points)
    hulls = list(map(graham, map(list, batched(points, n=m)))) #dzielimy na n / m otoczek, aplikujemy grahama na kazda

    p1 = max(points, key=lambda p: (p[0], p[1])) #najbardziej na prawo
    last = p1
    L = [last]

    for hull in hulls:
        xh, yh = zip(*(hull + [hull[0]]))

    for j in range(m):
        best = points[0] if points[0] != last else points[1] 
        for i in range(len(hulls)):
            q = rtangent(hulls[i], last) 
            d = det(last,best,q)
            if d < -eps or (d < eps and dist(last,best) < dist(last,q)):
                best = q
        L.append(best)
        last = best
        if best == p1:
            L.pop()  # usuwamy powtorzony punkt startowy
            return L
        
    return None

def chan(points):
    t = 0
    n = len(points)
    while True:
        m = min(n, 2**(2**t))
        result = step_chan(points, m)
        if result != None:
            return result
        t += 1

def chan_vis(points, title='Chan', path=None):
    pass

def step_chan_vis(points, m):
    pass



