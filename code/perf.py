import time
import numpy as np
import matplotlib.pyplot as plt
from tests import generate_circle_points, generate_uniform_points, generate_zigzag_points

def benchmark_convex_hull(convex_hull, generator, ns, step, **kwargs,):
    """
    Generuje punkty i mierzy czas wykonania otoczki wypukłej dla różnych n.
    
    :param convex_hull: funkcja otoczki
    :param generator: funkcja generująca punkty, np. generate_uniform_points
    :param ns: lista liczb punktów [100, 500, 1000, ...]
    :param kwargs: dodatkowe argumenty do generatora
    """
    times = []

    for n in range(2,ns,step):
        pts = generator(n=n, **kwargs)
        pts_np = np.array(pts)
        start = time.perf_counter()
        convex_hull(pts)
        elapsed = (time.perf_counter() - start) * 1000.0
        times.append(elapsed)
    
    plt.figure(figsize=(7,5))
    plt.plot([n for n in range(2,ns,step)], times, 'o-', label=generator.__name__)
    plt.xlabel('Liczba punktów n')
    plt.ylabel('Czas wykonania [s]')
    plt.title(f'Czas {convex_hull.__name__} dla generatora {generator.__name__}')
    plt.grid(True)
    plt.legend()
    plt.show()

from graham import graham
from jarvis import jarvis
from incremental import incremental
from monochain import monochain
from quickhull import quickhull
from chan import chan
from divide_and_conquer import divide_and_conquer
chulls = [graham, jarvis, incremental, monochain, quickhull, chan, divide_and_conquer]
for f in chulls:
    benchmark_convex_hull(f, generate_uniform_points, 1000, 50)
