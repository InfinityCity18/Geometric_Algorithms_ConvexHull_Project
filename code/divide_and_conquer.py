from graham import *
from itertools import *
eps = 1e-12

def x_sort(points):
    points.sort()
    res = []
    for x, pts in groupby(points, key=lambda p: p[0]):
        pts = list(pts)
        res.append(pts[0])
        if len(pts) > 1 and pts[-1] != pts[0]:
            res.append(pts[-1])
    return res

def det(a, b, c):
    return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])

def get_rightmost_index(h):
    return max(range(len(h)), key=lambda i: h[i][0])

def get_leftmost_index(h):
    return min(range(len(h)), key=lambda i: h[i][0])

def merge_hulls(h1, h2, i1, i2):
    n1, n2 = len(h1), len(h2)

    up1, up2 = i1, i2
    while True:
        moved = False
        while det(h1[up1], h2[up2], h2[(up2-1)%n2]) >= -eps:
            up2 = (up2-1) % n2
            moved = True
        while det(h2[up2], h1[up1], h1[(up1+1)%n1]) <= eps:
            up1 = (up1+1) % n1
            moved = True
        if not moved:
            break

    down1, down2 = i1, i2
    while True:
        moved = False
        while det(h1[down1], h2[down2], h2[(down2+1)%n2]) <= eps:
            down2 = (down2+1) % n2
            moved = True
        while det(h2[down2], h1[down1], h1[(down1-1)%n1]) >= -eps:
            down1 = (down1-1) % n1
            moved = True
        if not moved:
            break

    res = []
    i = up1
    res.append(h1[i])
    while i != down1:
        i = (i+1) % n1
        res.append(h1[i])

    i = down2
    res.append(h2[i])
    while i != up2:
        i = (i+1) % n2
        res.append(h2[i])

    return res

def divide_and_conquer(points, k=3):
    points = x_sort(points)
    blocks = []
    stack = [points]

    while stack:
        P = stack.pop()
        if len(P) <= k:
            blocks.append(P)
        else:
            m = len(P)//2
            stack.append(P[:m])
            stack.append(P[m:])

    blocks.sort(key=lambda P: P[0][0])
    hulls = [graham(P) for P in blocks]

    while len(hulls) > 1:
        nxt = []
        for i in range(0, len(hulls)-1, 2):
            h1, h2 = hulls[i], hulls[i+1]
            i1 = get_rightmost_index(h1)
            i2 = get_leftmost_index(h2)
            nxt.append(merge_hulls(h1, h2, i1, i2))
        if len(hulls) % 2:
            nxt.append(hulls[-1])
        hulls = nxt.copy()
    return hulls[0]

def divide_and_conquer_vis(points, k=3, title="Divide and Conquer", path=None):
    from drawing import Visualizer
    viz = Visualizer(f"{title} n = {len(points)}")
    viz.auto_set_bounds(points)
    viz.add_permament([("points","gray",points)])
    num_frames = 0


    points = x_sort(points)
    blocks = []
    stack = [points]

    while stack:
        P = stack.pop()
        if len(P) <= k:
            blocks.append(P)
        else:
            m = len(P)//2
            stack.append(P[:m])
            stack.append(P[m:])

    blocks.sort(key=lambda P: P[0][0])
    hulls = [graham(P) for P in blocks]

    def snap(c_hulls):
        nonlocal num_frames
        num_frames += 1
        frame = []
        for H in c_hulls:
            frame.append(("polygon", "red", H))
        viz.add_frame(frame)

    snap(hulls)
    while len(hulls) > 1:
        nxt = []
        for i in range(0, len(hulls)-1, 2):
            h1, h2 = hulls[i], hulls[i+1]
            i1 = get_rightmost_index(h1)
            i2 = get_leftmost_index(h2)
            nxt.append(merge_hulls(h1, h2, i1, i2))
            snap(nxt + hulls[i+2:])
        if len(hulls) % 2:
            nxt.append(hulls[-1])
        hulls = nxt.copy()
        snap(hulls)

    viz.add_frame([("polygon", "red", hulls[0]),("points", "red", hulls[0],10)])
    viz.draw_animation(10000/num_frames, path)

