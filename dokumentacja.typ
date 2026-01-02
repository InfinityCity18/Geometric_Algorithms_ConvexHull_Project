#set text(lang: "pl", size: 12pt)
#set par(justify: true)
#set heading(numbering: "1.")
#set grid(column-gutter: 1em)
#set table(align: center + horizon)
#set page(numbering: "1")
#show table: set par(justify: false)
#show table.cell.where(y: 0): strong

#let unit(x) = $space  upright(#x) $

#line(length: 100%)

#align(center)[
  #text(size: 2.0em)[*Otoczka wypukła dla zbioru punktów w przestrzeni dwuwymiarowej*] \

  #text(size: 1.5em)[*Temat 2, Grupa 2*] \

  #text(size: 1.2em)[Autorzy: Remigiusz Babiarz, Jakub Własiewicz] \
  #text(size: 1.2em)[6 stycznia 2026]
]

= Wstęp
\
Ćwiczenie polegało na implementacji algorytmów wyznaczania otoczki wypukłej zaprezentowanych na wykładzie. Zaimplementowane zostały algorytmy:
- *Grahama*,
- *Jarvisa*,
-  przyrostowy wyznaczania otoczki wypukłej (dalej *przyrostowy*)
-  górnej i dolnej otoczki, wyznaczający dwa monotoniczne łańcuchy będące połowami otoczki (dalej *monochain*),
- *quickhull*,
- *Chan'a*.
Powyższe algorytmy następnie przetestowano na uprzednio przygotowanych danych testowych oraz porównano ich działanie. Przygotowano wizualizację działania każdego z algorytmów.

= Szczegóły techniczne
biblioteki itd, komkuter, struktura plików

= Realizacja ćwiczenia
== Dane wejściowe
Przyjmujemy, że zbiorem danych wejściowych jest zbiór punktów na płaszczyźnie. Punkty są krotkami zawierającymi dwie liczby zmiennoprzecinkowe reprezentujące ich współrzędne. Przyjmujemy, że w zbiorze punktów nie ma żadnych duplikatów (punktów o tych samych współrzędnych). Mogą natomiast wystąpić pary punktów o tej samej współrzędnej.
== Oczekiwany wynik działania algorytmów
Każdy z zaimplementowanych algorytmów ma w założeniu wyznaczyć otoczkę wypukłą punktów z danych wejściowych. Za poprawną otoczkę przyjmuje się listę punktów taką, że:
- punkty z tej listy są wierzchołkami wielokąta następującymi po sobie w kolejności przeciwnej do ruchu wskazówek zegara,
- wielokąt ten jest otoczką wypukłą zbioru danych wejściowych.
== Omówienie implementacji algorytmów
=== Elementy wspólne
==== Wyznacznik
Funkcja _det(a,b,c)_ została[...]
=== Algorytm Grahama
Plik *graham.py*.
==== Przebieg algorytmu
Algorytm rozpoczyna działanie od przygotowania danych. Najpierw znajduje w zbiorze wejściowym punkt *_lowest_point_* o najniższej drugiej współrzędnej, lub - w przypadku remisu - punkt o najniższych współrzędnych. Następne sortuje pozostałe punkty na podstawie kątu jaki tworzy odcinek tworzony przez dany punkt oraz punkt *_lowest_point_* z osią *_OX_*. Kąt ten jest obliczany z pomocą funkcji _atan2_ z biblioteki _numpy_. W przypadku remisu punkty porządkowane są w kierunku rosnącej odległości od puntu *_lowest_point_*. Ostatnim krokiem przygotowującym dane jest usunięcie z posortowanej listy punktów punktów współliniowych - w przypadku trójki (*_lowest_point_*, *_p_*, *_q_*), gdzie punkt *_p_* leży na odcinku (*_lowest_point_*, *_q_*) punkt *_p_* jest usuwany ze zbioru danych. 
\
\
Następnie algorytm iteracyjnie wyznacza otoczkę wypukłą przygotowanego zbioru. Tworzy stos *_hull_*, na którym umieszcza *_lowest_point_*. Następnie dla każdego kolejnego punktu *_p_* z posortowanej listy wykonuje:
- dopóki na stosie są co najmniej 2 punkty sprawdź relację dwóch ostatnich punktów na stosie z punktem *_p_* z użyciem funkcji _det_:
-- jeśli _det(*przedostatni punkt*, *ostatni punkt*, *p*) <= $epsilon$_ (skręt w prawo), usuń ostatni punkt ze stosu,\
-- w przeciwnym wypadku, dodaj punkt *_p_* na górę stosu.
\
\
Po przetworzeniu wszystkich punków na stosie pozostaje lista wynikowa będąca otoczką wypukłą zbioru punktów z danych wejściowych.
=== Algorytm Jarvisa
Plik *jarvis.py*
==== Przebieg algorytmu
Algorytm jest inaczej nazywany algorytmem _owijania prezentu_ (ang. _gift wrapping_). Podobnie jak algorytm Grahama (3.3.2) rozpoczyna działanie od znalezienia punktu *_lowest_point_* o najmniejszej pierwszej współrzędnej, lub - w przypadku remisu - o najmniejszych obu współrzędnych. Następnie algorytm znajduje następny punkt należący do otoczki z pomocą funkcji _det_ - iternuje po wszystkich punktach znajdując taki punkt *_best_* dla którego wszystkie inne punkty leżą po lewej stronie odcinka (*_last_*, *_best_*), gdzie *_last_* jest ostatnim znalezionym punktem należącym do otoczki. Algorytm krok ten powtarza aż znaleziony zostanie punkt startowy, co reprezentuje zamknięcie otoczki. 
