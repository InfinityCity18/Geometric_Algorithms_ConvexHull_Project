import matplotlib.pyplot as plt
from matplotlib.backend_bases import MouseButton
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

