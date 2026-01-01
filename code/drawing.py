import matplotlib.pyplot as plt
from matplotlib.backend_bases import MouseButton
import matplotlib.animation as animation
from matplotlib.patches import Polygon
import numpy as np
class Visualizer:
    _COLOR_POOL = ["blue", "cornflowerblue", "violet", "plum", "turquoise", "aquamarine"]

    def __init__(self, title, limx = (-10,10), limy = (-10,10), width=6, height=6):
        self.frames = []          
        self.fig, self.ax = plt.subplots(figsize=(width, height))
        self.ax.set_aspect('equal')
        self.limx = limx
        self.limy = limy
        self.width = width
        self.height = height
        self.title = title
        self.permament = []
        self.color_it = -1
    
    def auto_set_bounds(self, points):
        xmin = min(points, key = lambda p: p[0])[0]
        xmax = max(points, key = lambda p: p[0])[0]
        ymin = min(points, key = lambda p: p[1])[1]
        ymax = max(points, key = lambda p: p[1])[1]
        xlen = xmax - xmin
        ylen = ymax - ymin
        self.limx = (xmin - xlen*0.1, xmax + xlen*0.1)
        self.limy = (ymin - ylen*0.1, ymax + ylen*0.1)

    def next_color(self):
        self.color_it += 1
        return self._COLOR_POOL[self.color_it%len(self._COLOR_POOL)]

    def add_frame(self, frame_data):
        """
        a single frame_data should follow the format:
        (figure type, color, coordinates)
        examples:
        ("points", "black", [(0,0), (1,1)]),
        ("polygon", "red", [(0,0), (0,1), (1,0)]),
        ("lines", "blue", [((0,0), (5,5))])
        """
        tmp = []
        for f in frame_data:
            if len(f) == 3:
                f = (f[0], f[1], f[2], None)
            tmp.append(f)
        self.frames.append(tmp)
 
    def add_permament(self, frame_data):
        """
        same format as add_frame. Draws the provided geometry every frame. 
        """
        for f in frame_data:
            if len(f) == 3:
                f = (f[0], f[1], f[2], None)
            self.permament.append(f)

    def _draw_frame(self, frame_idx):
        self.ax.clear()
        self.ax.set_xlim(self.limx) 
        self.ax.set_ylim(self.limy) 
        self.ax.set_title(self.title)
        self.ax.grid(True, linestyle='--', alpha=0.6)
        
        frame_idx = min(len(self.frames)-1, frame_idx)
        
        current_frame = self.frames[frame_idx]

        for shape_type, color, data, zorder in current_frame + self.permament:
            if shape_type == "points":
                self._draw_points(data, color, zorder)
            elif shape_type == "polygon":
                self._draw_polygon(data, color,True, zorder)
            elif shape_type == "polygon_open":
                self._draw_polygon(data, color,False, zorder)
            elif shape_type == "lines":
                self._draw_lines(data, color, zorder)
            else:
                print(f"Unknown shape type '{shape_type}'")

    def _draw_points(self, points, color, zorder):
        if not zorder: zorder = 1
        if not points: return
        X, Y = zip(*points)
        self.ax.scatter(X, Y, c=color, s=25, zorder=zorder)

    def _draw_polygon(self, vertices, color, closed,zorder):
        if not zorder: zorder = 2
        if not vertices: return
        poly = Polygon(vertices, linewidth=2, closed=closed, fill=False, edgecolor=color, zorder=zorder) 
        self.ax.add_patch(poly)

    def _draw_lines(self, lines, color,zorder):
        if not zorder: zorder = 3
        for start, end in lines:
            X = [start[0], end[0]]
            Y = [start[1], end[1]]
            self.ax.plot(X, Y, c=color, linewidth=2, zorder=zorder)

    def draw_animation(self, ms_per_frame=500, save_path=None):
        if not self.frames:
            print("No frames to animate.")
            return

        end_frames = int(2000/ms_per_frame)

        ani = animation.FuncAnimation(
            self.fig, 
            self._draw_frame, 
            frames=len(self.frames)+end_frames, 
            interval=ms_per_frame, 
            repeat=True
        )

        if save_path:
            ani.save(save_path, writer='pillow')
            print(f"Animation saved to {save_path}")
        else:
            plt.show()

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


def user_input_points(): #wprowadzanie punktóœ
    fig, ax = plt.subplots(figsize=(6,6))
    
    fig.canvas.manager.set_window_title('Wprowadzanie punktów')
    ax.set_title('Lewy przycisk: dodaj punkt | Prawy przycisk: cofnij | Enter: zakończ')
    
    x, y = [], []
    scat= ax.scatter(x, y, color="black", s=5)
    
    ax.set(xlim=(-1, 1), ylim=(-1, 1))
    input_points = []
    
    def update_plot():
        scat.set_offsets(input_points)
        fig.canvas.draw_idle()

    def on_click(event):
        nonlocal input_points
        if event.inaxes:
            if event.button is MouseButton.LEFT:
                x.append(event.xdata)
                y.append(event.ydata)
                input_points.append((event.xdata, event.ydata))
                update_plot()
                
            elif event.button is MouseButton.RIGHT:
                if len(x) > 0:
                    x.pop()
                    y.pop()
                    input_points.pop()
                    update_plot()
                    
    def on_key(event):
        if event.key == 'enter':
            plt.close(fig)
            
    fig.canvas.mpl_connect('button_press_event', on_click)
    fig.canvas.mpl_connect('key_press_event', on_key)

    plt.show()
    
    return input_points

def draw_example():
    viz = Visualizer("Example animation")

    frame_1 = [
        ("points", "black", [(0, 0), (2, 2), (-2, -2)]),
        ("polygon", "red", [(-4, 4), (-2, 4), (-3, 6)]),
        ("lines", "blue", [((-5, -5), (5, -5))])
    ]
    viz.add_frame(frame_1)

    frame_2 = [
        ("points", "black", [(1, 0), (3, 2), (-1, -2)]),
        ("polygon", "green", [(-3, 3), (-1, 3), (-2, 5)]),
        ("lines", "blue", [((-5, -4), (5, -4))])
    ]
    viz.add_frame(frame_2)
    
    frame_3 = [
         ("points", "black", [(2, 0), (4, 2), (0, -2)]),
         ("polygon", "purple", [(-2, 2), (0, 2), (-1, 4)]),
         ("lines", "orange", [((-5, -3), (5, -3))])
    ]
    viz.add_frame(frame_3)

    viz.draw_animation(1000, "meow.gif")
