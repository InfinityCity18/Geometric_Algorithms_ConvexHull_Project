from algorithms import * 
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from numpy import abs, atan2
eps = 10**-12

def draw_points(points):
    x, y = zip(*points)
    plt.figure(figsize=(6,6))
    plt.xlabel("x")
    plt.ylabel("y")
    plt.scatter(x, y)
    plt.show()

def draw_hull(points,hull):
    x, y = zip(*points)
    hull.append(hull[0])
    xh, yh = zip(*hull)
    plt.figure(figsize=(6,6))
    plt.xlabel("x")
    plt.ylabel("y")
    plt.scatter(x, y)
    plt.scatter(xh, yh,color ="red",s=50)
    plt.plot(xh,yh,color="red")
    plt.show()




def draw_animation(points, snaps, frames_per_second, filename, title):
    red_snapshots, blue_snapshots = snaps
    n = len(red_snapshots)
    Xp, Yp = zip(*points)
    fig, ax = plt.subplots()
    plt.xlabel("x")
    plt.ylabel("y")
    plt.title(title)
    offsetx = (max(Xp) - min(Xp)) * 0.1
    offsety = (max(Yp) - min(Yp)) * 0.1
    ax.set_xlim(min(Xp) - offsetx, max(Xp) + offsetx)
    ax.set_ylim(min(Yp) - offsety, max(Yp) + offsety)
    
    scat = ax.scatter(Xp, Yp, s=10, color='grey')
    
    (red_line,) = ax.plot([], [], color='red')
    red_scat = ax.scatter([], [], s=30, color='red')

    (blue_line, ) = ax.plot([],[],color='blue',linewidth=3)
    blue_scat = ax.scatter([], [], s=35, color='blue')

    def update(i):
        X_red, Y_red = zip(*red_snapshots[i])
        X_blue, Y_blue = zip(*blue_snapshots[i])
        red_line.set_data(X_red, Y_red)
        red_scat.set_offsets(red_snapshots[i])
        blue_line.set_data(X_blue, Y_blue)
        blue_scat.set_offsets(blue_snapshots[i])
        return scat, red_line, blue_line, red_scat, blue_scat
    
    ani = FuncAnimation(fig, update, frames=n, interval=10/n, repeat=False)
    ani.save(f"gifs/{filename}.gif", writer="pillow", fps=frames_per_second)


def graham_snapshots(points):
    lowest_point = min(points, key=lambda p: (p[1], p[0]))
    points.remove(lowest_point)
    
    points.sort(key=lambda p: (
        atan2(p[1] - lowest_point[1], p[0] - lowest_point[0]),
        (p[0] - lowest_point[0])**2 + (p[1] - lowest_point[1])**2
    ))
    
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

   
    snapshots = []
    snapshots_h = []

    def snap(p):
        snapshots.append(hull.copy())
        snapshots_h.append([p])
    
    hull = [lowest_point]
    for p in points:
        while len(hull) >= 2 and det(hull[-2], hull[-1], p) <= eps:
            snap(p)
            hull.pop()
        hull.append(p)
        snap(p)
    
    snap(p)
    hull.append(lowest_point)
    snapshots.append(hull.copy())
    snapshots_h.append(hull.copy())
    
    return snapshots,snapshots_h

def jarvis_snapshots(points):
    n = len(points)
    lowest_point = min(points,key = lambda p: (p[1],p[0]))
    def dist(p1,p2):
        return (p1[0] - p2[0])**2 + (p1[1]-p2[1])**2
    
    convex_hull = []
    last = lowest_point
   
    snapshots = []
    snapshots_h = []
    snapshots.append([last])
    snapshots_h.append([last])
    
    while True:
        convex_hull.append(last)
        best = points[0] if points[0] != last else points[1]
        for p in points:
            snapshots.append(convex_hull.copy() + [best])
            snapshots_h.append([convex_hull[-1], p])
            if p == last:
                continue
            d = det(last, best, p)
            if d < -eps or (d < eps and dist(last,best) < dist(last,p)):
                best = p
        last = best
        if last == lowest_point:
            break
    convex_hull.append(lowest_point)
    snapshots.append(convex_hull.copy())
    snapshots_h.append(convex_hull.copy())
    return snapshots, snapshots_h

def gif_graham(points, filename, set_name):
    draw_animation(points,graham_snapshots(points.copy()), 30, filename, f"Graham, Zbiór {set_name}, {len(points)} punkty")
def gif_jarvis(points, filename, set_name):
    draw_animation(points,jarvis_snapshots(points.copy()), 30, filename, f"Jarvis, Zbiór {set_name}, {len(points)} punkty")

