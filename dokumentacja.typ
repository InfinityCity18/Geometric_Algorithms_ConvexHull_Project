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
- *dziel i rządź*,
- *quickhull*,
- *Chana*.
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
Algorytm rozpoczyna działanie od przygotowania danych. Najpierw znajduje w zbiorze wejściowym punkt *_lowest_point_* o najniższej drugiej współrzędnej, lub - w przypadku remisu - punkt o najniższych współrzędnych. Następne sortuje pozostałe punkty na podstawie kątu jaki tworzy odcinek tworzony przez dany punkt oraz punkt *_lowest_point_* z osią *_OX_*. Kąt ten jest obliczany z pomocą funkcji _atan2_ z biblioteki _numpy_. W przypadku remisu punkty porządkowane są w kierunku rosnącej odległości od puntu *_lowest_point_*. Ostatnim krokiem przygotowującym dane jest usunięcie z posortowanej listy punktów współliniowych - w przypadku trójki (*_lowest_point_*, *_p_*, *_q_*), gdzie punkt *_p_* leży na odcinku (*_lowest_point_*, *_q_*), punkt *_p_* jest usuwany ze zbioru danych. 
\
\
Następnie algorytm iteracyjnie wyznacza otoczkę wypukłą przygotowanego zbioru. Tworzy stos *_hull_*, na którym umieszcza *_lowest_point_*. Następnie, dla każdego kolejnego punktu *_p_* z posortowanej listy wykonuje:
- dopóki na stosie są co najmniej 2 punkty sprawdź relację dwóch ostatnich punktów na stosie z punktem *_p_* z użyciem funkcji _det_:
-- jeśli _det(*przedostatni punkt*, *ostatni punkt*, *p*) <= 0_ (skręt w prawo), usuń ostatni punkt ze stosu,\
-- w przeciwnym wypadku, dodaj punkt *_p_* na górę stosu.
\
\
Po przetworzeniu wszystkich punków na stosie pozostaje lista wynikowa będąca otoczką wypukłą zbioru punktów z danych wejściowych.
==== Analiza złożoności obliczeniowej
Cały algorytm ma złożoność obliczeniową _O(nlog(n))_, gdzie $n$ to liczba punktów na płaszczyźnie. Najbardziej kosztownym etapem algorytmu jest sortowanie punktów - wykonuje się ono w czasie _O(nlog(n))_. Następny etap algorytmu jest iteracją po punktach i wymaga czasu $O(n)$. Algorytm Grahama jest bardzo uniwersalnym algorytmem o przewidywalnym czasie działania dla każdego zbioru danych.
=== Algorytm Jarvisa
Plik *jarvis.py*.
==== Przebieg algorytmu
Algorytm jest inaczej nazywany algorytmem _owijania prezentu_ (ang. _gift wrapping_). Podobnie jak algorytm Grahama (3.3.2) rozpoczyna działanie od znalezienia punktu *_lowest_point_* o najmniejszej pierwszej współrzędnej, lub - w przypadku remisu - o najmniejszych obu współrzędnych. Następnie algorytm znajduje następny punkt należący do otoczki z pomocą funkcji _det_ - iteruje po wszystkich punktach znajdując taki punkt *_best_*, dla którego wszystkie inne punkty leżą po lewej stronie odcinka (*_last_*, *_best_*), gdzie *_last_* jest ostatnim znalezionym punktem należącym do otoczki. Algorytm krok ten powtarza aż znaleziony zostanie punkt startowy, co reprezentuje zamknięcie otoczki. 
==== Analiza złożoności obliczeniowej
Algorytm Jarvisa ma złożoność _O(nk)_, gdzie _n_ to liczba punktów na płaszczyźnie, oraz _k_ to liczba punktów należących do otoczki. Wynika ona z prostego faktu znajdowania jednego punktu należącego do otoczki w każdym kroku algorytmu, która objemuje iteracje po wszystkich punktach ze zbioru wejściowego. Faktyczny czas działania algorytmu może być nieprzewidywalny i jest bardzo wrażliwy na różne dane wejściowe - w oczywisty algorytm Jarvisa nie jest najlepszym wyborem do wyznaczania otoczek zbiorów punktów o potencjalnie wielu punktach należących do otoczki.
=== Algorytm przyrostowy
Plik *incremental.py*.
==== Przebieg algorytmu
Algorytm najpierw sortuje punkty względem ich współrzędnej *_x_*. W przypadku gdy istnieje wiele punktów o tej samej współrzędnej *_x_* punkt o najmniejszej współrzędnej *_y_* jest umieszczany przed punktem o największej współrzędnej *_y_*, a wszystkie pozostałe punkty są usuwane. 
Algorytm tworzy pierwszą otoczkę na podstawie dwóch pierwszych punktów posortowanego zbioru. Następnie iteracyjnie dodaje każdy z pozostałych punktów do otoczki. Dołączanie punktu opiera się na znalezieniu stycznych do otoczki przechodzących przez ten punkt i usunięcie wszystkich punktów otoczki, które znajdowałyby się wewnątrz otoczki po dodaniu do niej rozważanego punktu.
\
\
Styczne znajdowane są z pomocą funkcji _det_.
==== Analiza złożoności algorytmu
Algorytm ma złożoność _O(nlog(n))_, gdzie _n_ to liczba punktów na płaszczyźnie. Samo sortowanie punktów zajmuje _O(nlog(n))_ czasu procesora. Podczas iteracyjnego dołączania punktów do otoczki każdy punkt jest dodawany do otoczki raz i maksymalnie raz z niej usuwany, złożoność tego kroku wynosi więc _O(n)_, a finalna złożoność algorytmu przyrostowego to faktycznie _O(nlog(n))_.

=== Algorytm górnej i dolnej otoczki
Plik *monochain.py*.
==== Przebieg algorytmu
Podobnie jak algorytm przyrostowy, algorytm górnej i dolnej otoczki zaczyna od posortowania punktów względem współrzędnej *_x_* i usunięcia punktów współliniowych o tej samej współrzędnej *_x_*. 
\
\
Następnie algorytm iteracyjnie konstuuje górną otoczkę punktów. Początkowa górna otoczka składa się z dwóch pierwszych punktów w posortowanym zbiorze. Każdy kolejny punkt jest dodawany do górnej otoczki, po uprzednim usunięciu z niej wszystkich punktów, których obecność naruszyła by warunek wypukłości, który sprawdzany jest z użyciem funkcji _det_. Dolna otoczka wyznaczana jest analogicznie.
\
\
Ostatnim krokiem algorytmu jest połączenie górnej i dolnej otoczki z uwagą na warunek prawoskrętności otoczki.
==== Analiza złożoności obliczeniowej
Sortowanie punktów wykonywane jest w czasie _O(nlog(n))_, gdzie _n_ to liczba punktów na płaszczyźnie. Każdy punkt jest przetwarzany w iteracyjnej części algorytmu stałą liczbę razy. Finalna złożoność algorytmu górnej i dolnej otoczki to więc _O(nlog(n))_.

=== Algorytm dziel i rządź
Plik *divide_and_conquer.py*.
==== Przebieg algorytmu
Algorytm opiera się na utworzeniu zbioru otoczek, które w sumie obejmują cały zbiór punktów wejściowych, oraz na późniejszym łączeniu ich w czasie stałym do momentu otrzymania jednej otoczki obejmującej cały zbiór.
\
\
Pierwszym krokiem jest posortowanie punktów względem współrzędnej *_x_*. Następnie tak posortowana lista jest dzielona na części. Każda z tych części jest listą kolejnych *_k_* punktów należących do posortowanej listy wejściowej, gdzie *_k_* jest małą stałą będącą parametrem algorytmu. Następnie dla każdego z tych podzbiorów punktów wyznaczana jest otoczka wypukła z użyciem algorytmu Grahama.
\
\
Tak powstałe sąsiednie otoczki są łączone poprzez znajdowanie stycznych z użyciem funkcji _det_. Łączenie to jest powtarzane do momentu otrzymania jednej otoczki będącej połączeniem wszystkich otoczek.
==== Analiza złożoności obliczeniowej
Samo sortowanie zbioru wejściowego wykonuje się w czasie _O(nlog(n))_. Wyznaczanie otoczek podzbiorów dla małej stałej *_k_* zajmuje stały czas O(k). Ponieważ ten krok powtarzany jest dla _n/k_ otoczek zajmuje on w sumie $O(k times n/k) = O(n)$ czasu procesora. Łączenie 2 otoczek zajmuje stały czas, a samych otoczek do połączenia jest $n/k$. Czas poświęcany na ten krok wynosi więc $O(n/k l o g(n/k)) = O(n l o g (n))$. Finalna złożoność algorytmu wynosi więc _O(nlogn_).
=== Algorytm Quickhull
Plik *quickhull.py*
==== Przebieg algorytmu
Algorytm rozpoczyna pracę od znalezienia 4 punktów o skrajnych współrzędnych:
- maksymalnej współrzędnej _*x*_,
- minimalnej współrzędnej _*x*_,
- maksymalnej współrzędnej _*y*_,
- minimalnej współrzędnej _*y*_.
Punkty te definiują 4 odcinki, które tworzą wielokąt. Wielokąt ten określamy otoczką, którą będziemy rekurencyjnie rozszerzać. Wszystkie punkty wewnątrz otoczki są usuwane.
Pozostałe punkty przetwarzane są rekurencyjnie z użyciem metody _dziel i rządź_ poprzez wywoływanie funkcji *_rec_hull_*, która działa następująco:\
Dla danego odcinka znajdowany jest punkt znajdujący się najdalej od niego i będący na zewnątrz wielokąta tworzonego przez aktualne punkty otoczki. Punkt ten wraz z końcami rozpatrywanego odcinka definuje 2 kolejne odcinki, które dodawane są do otoczki. Na tych nowych odcinkach rekurencyjnie wywoływana jest funckja *_rec_hull_* tak długo jak istnieją punkty poza otoczką.
==== Analiza złożoności obliczeniowej
Każde rekurencyjne wywołanie fukcji *_rec_hull_* iteruje się po zbiorze punktów, którego rozmiar jest proporcjonalny do rozmiaru zbioru wejściowego. Ilość takich wywołań w pełni zależy od charakterystyki zbioru wejściowego. W pesymistycznym przypadku w każdym wywołaniu *_rec_hull_* jedyny usuwany punkt jest tym najbardziej odległym od rozpatrywanego odcinka, wtedy liczba wywołań wynosi _n_, a pesymistyczna złożoność obliczeniowa wynosi _O(n^2)_. Przypadek ten zachodzi gdy wszystkie punkty, lub ich większość należy do otoczki.
Realistycznie jednak, zakładając względnie równomierne rozłożenie punktów, przy każdym "powiększaniu" otoczki przez funkcję *_rec_hull_* punkty należące do obszaru proporcjonalnego do długości odcinka są usuwane. Zamortyzowana złożoność obliczeniowa wynosi więc _O(nlog(n))_.

