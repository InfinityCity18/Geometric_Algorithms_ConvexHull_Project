import numpy as np
import time
from src.drawing import *

np.random.seed(13)

def generate_uniform_points(left=-100, right=100, n=100):
    return [(np.random.uniform(left, right), np.random.uniform(left, right)) for _ in range(n)]

def generate_circle_points(O=(0,0), R=100, n=100):
    points = []
    for i in range(n):
        angle = np.random.uniform(0, 2*np.pi)
        points.append((O[0] + R * np.sin(angle), O[1] + R * np.cos(angle)))
    return points

def generate_square_points(n=100, half_a=50):
    points = []
    for i in range(4):
        for _ in range(n//4):
            match i:
                case 0:
                    points.append((np.random.uniform(-half_a, half_a),half_a))
                case 1:
                    points.append((np.random.uniform(-half_a, half_a),-half_a))
                case 2:
                    points.append((half_a, np.random.uniform(-half_a, half_a)))
                case 3:
                    points.append((-half_a,np.random.uniform(-half_a, half_a)))
    np.random.shuffle(points)
    return points

def generate_x_square_points(n=100, half_a=50):
    points = [(half_a, half_a), (half_a, -half_a), (-half_a, half_a), (-half_a, -half_a)]
    for i in range(4):
        for _ in range(n//4):
            match i:
                case 0:
                    points.append((np.random.uniform(-half_a, half_a),half_a))
                case 1:
                    points.append((np.random.uniform(-half_a, half_a),-half_a))
                case 2:
                    points.append((half_a, np.random.uniform(-half_a, half_a)))
                case 3:
                    points.append((-half_a,np.random.uniform(-half_a, half_a)))
    for i in range(2):
        for _ in range(n//4):
            match i:
                case 0:
                    x = np.random.uniform(-half_a, half_a)
                    points.append((x, x))
                case 1:
                    x = np.random.uniform(-half_a, half_a)
                    points.append((x, -x))
    np.random.shuffle(points)
    return points

def generate_zigzag_points(width=100, height=100, n=100, amplitude=10, period=10):
    points = [(np.random.uniform(-width, width), np.random.uniform(-height, height)) for _ in range(n)]
    n = 2 * width // period
    for i in range(n):
        x = -width + i * period
        y = -height + amplitude * ((-1) ** i)
        points.append((x, y))
    for i in range(n):
        x = -width + i * period
        y = height + amplitude * ((-1) ** i)
        points.append((x, y))
    n = 2 * height // period
    for i in range(n):
        x = -width + amplitude * ((-1) ** i)
        y = -height + i * period
        points.append((x, y))
    for i in range(n):
        x = width + amplitude * ((-1) ** i)
        y = -height + i * period
        points.append((x, y))
    np.random.shuffle(points)
    return points

def get_generators():
    gens = []
    gens.append((generate_uniform_points, "Generuje losowe punkty o współrzędnych z zakresiu [-100,100]"))
    gens.append((generate_circle_points, "Generuje losowe punkty leżące na kole o promieniu 100"))
    gens.append((generate_zigzag_points, "Generuje losowe punkty wewnątrz kwadratowego obszaru, które otoczone są obramówką"))
    gens.append((generate_square_points, "Generuje losowe punkty leżące na obwodzie kwadratu o boku 100"))
    gens.append((generate_x_square_points, "Generuje losowe punkty leżące na obwodzie kwadratu o boku 100 oraz na jego przekątnych"))
    return gens

def benchmark_convex_hull(convex_hull_algs, generator, ns, **kwargs,):
    """
    Generuje punkty i mierzy czas wykonania otoczki wypukłej dla różnych n.
    
    :param convex_hull: lista funkcji otoczki
    :param generator: funkcja generująca punkty, np. generate_uniform_points
    :param ns: lista liczb punktów [100, 500, 1000, ...]
    :param kwargs: dodatkowe argumenty do generatora
    """
    fig, ax = plt.subplots(figsize=(7,5))

    pts_array = [generator(n=n, **kwargs) for n in ns]
    
    for n in ns:
        print(n, end='\t')
    print("n")
    for alg in convex_hull_algs:
        times = []
        for pts in pts_array:
            start = time.perf_counter_ns()
            alg(pts)
            elapsed = (time.perf_counter_ns() - start) / 1e6
            times.append(elapsed)
            print("{:.2f}".format(elapsed), end='\t')
        print(f"czas {alg.__name__}", end='\t')
        print()
        ax.plot(ns, times, 'o-', label=alg.__name__)
        
    ax.set_xlabel('Liczba punktów n')
    ax.set_ylabel('Czas wykonania [ms]')
    ax.set_title(f'Czasy wykonania dla generatora {generator.__name__}')
    ax.grid(True)
    ax.legend()
    plt.show()

