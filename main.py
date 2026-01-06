if __name__ != "main": exit
import numpy as np
import os
from src.tests import *
from src.drawing import *
from src.jarvis import *
from src.graham import *
from src.incremental import *
from src.monochain import *
from src.quickhull import *
from src.divide_and_conquer import *
from src.chan import *
ch_algorithms = [graham, jarvis, incremental , monochain, divide_and_conquer, quickhull, chan]
vis_algorithms = [graham_vis, jarvis_vis, incremental_vis , monochain_vis, divide_and_conquer_vis, quickhull_vis, chan_vis]

def save_points(points):
    print("Podaj nazwę pliku")
    filename = input()
    points = np.array(points)
    os.makedirs("./data", exist_ok = True)
    np.savetxt(f"./data/{filename}", points, fmt = "%.6f", comments = '')
    print(f"Zapisano zbiór do pliku ./data/{filename}")
    

def load_points():
    print("Wprowadź nazwę pliku. Plik powinien znajdować się w katalogu ./data/")
    inp = input()
    try:
        arr = np.loadtxt(f"./data/{inp}", delimiter=None)
        points = [tuple(row) for row in arr]
        print(f"Wczytano plik {inp}")
        return points
    except:
        print(f"Nie udało się wczytać pliku o nazwie {inp}")
        print("Program kończy działanie")
        exit()

def save_hull(hull):
    print("Podaj nazwę pliku")
    filename = input()
    hull = np.array(hull)
    os.makedirs("./hulls", exist_ok = True)
    np.savetxt(f"./hulls/{filename}", hull, fmt = "%f", comments = '')
    print(f"Zapisano otoczkę do pliku ./hulls/{filename}")

def input_range(start, end):
    print(f"Wprowadź liczbę od {start} do {end}")
    inp = None
    while not inp in range(start,end+1):
        inp = int(input())
    return inp

def select_generator():
    gens = get_generators()
    print("Dostępne generatory punktów:")
    for i in range(len(gens)):
        print(f"[{i+1}] - {gens[i][0].__name__} - {gens[i][1]}")
    inp = input_range(1, i+1)
    return gens[inp-1][0]

print("Czy chcesz uruchomić konkretny algorytm na jednym zbiorze danych, czy przeprowadzić analizę czasu działania różnych algorytmów dla konkretnego generatora?")
print("[1] - konkretny zbiór danych")
print("[2] - analiza dla generatora")
inp = input_range(1,2)
if inp == 2:
    g = select_generator()
    ns = list(range(10000, 200000, 10000))
    if g.__name__ == 'generate_circle_points': 
        ns = [10, 50, 100, 250, 500, 750, 1000]

    benchmark_convex_hull(ch_algorithms, g, ns)
    print("Koniec programu")
    exit()
print("Program wyznaczy otoczkę wypukłą zbioru punktów na płaszczyźnie, z użyciem zadanego algorytmu, na zadanym zbiorze danych.")
print("Jaki algorytm ma zostać zastosowany?")
print("[1] - algorytm Grahama")
print("[2] - algorytm Jarvisa")
print("[3] - algorytm przyrostowy")
print("[4] - algorytm górnej i dolnej otoczki")
print("[5] - algorytm dziel i rządź")
print("[6] - algorytm Quickhull")
print("[7] - algorytm Chana")
inp = input_range(1,7)
alg = ch_algorithms[inp-1]
vis = vis_algorithms[inp-1]
print("Na jakim zbiorze punktów uruchomić algorytm?")
print("[1] - wprowadzonym w sposób graficzny")
print("[2] - wczytanym z pliku")
print("[3] - wygenerowanym losowo")
inp = input_range(1,3)
testset = []
if inp == 1:
    print("Za moment otworzy się okno, które pozwoli na wprowadzenie punktów.")
    testset = user_input_points()
if inp == 2:
    testset = load_points()
    draw_points(testset.copy())
if inp == 3:
    g = select_generator()
    print("Ile punktów ma być wygenerowanych?")
    n = input_range(5, 500)
    testset = g(n=n)
    draw_points(testset.copy())

if inp == 1 or inp == 3:
    print("Czy zapisać punkty do pliku? [t/n]")
    inp = None
    while not inp in ['t', 'n']:
        inp = input()
    if inp == 't':
        save_points(testset.copy())

print("Wyznaczanie otoczki wypukłej...")
hull = alg(testset.copy())
draw_hull(testset.copy(), hull)
print("Czy chcesz zapisać otoczkę?[t/n]")
inp = None
while not inp in ['t', 'n']:
    inp = input()
if inp == 't':
    save_hull(testset.copy())

print("Czy chcesz zwizualizować działanie algorytmu?")
print("[1] - tak, w oknie")
print("[2] - tak, do pliku")
print("[3] - nie")
inp = input_range(1,3)
if inp == 1:
    vis(testset.copy())
if inp == 2:
    print("Podaj nazwę pliku.")
    filename = input()
    print(f"Plik zostanie zapisany w ./gifs/{filename}.gif")
    os.makedirs("./gifs", exist_ok = True)
    vis(testset.copy(), path=f"./gifs/{filename}.gif")
    print(f"Zapisano animację do pliku ./gifs/{filename}.gif")
    
print("Koniec działania programu")

