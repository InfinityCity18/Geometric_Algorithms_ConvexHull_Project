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
- *górnej i dolnej otoczki*,
- *dziel i rządź*,
- *quickhull*,
- *Chana*.
Powyższe algorytmy następnie przetestowano na uprzednio przygotowanych danych testowych oraz porównano ich działanie. Przygotowano wizualizację działania każdego z algorytmów.

= Szczegóły techniczne
== Dane sprzętowe
- *System operacyjny*: Fedora Linux 43
- *Środowisko*: NeoVim/Visual Studio Code
- *Język*: Python
- *Procesor*: 12th Gen Intel Core i5-12450H $times$ 12
== Użyte biblioteki
W projekcie wykorzystano funkcjonalności zarówno z biblioteki standardowej, jak i bibliotek zewnętrznych. Poniżej znajduje się lista importowanych modułów wraz z opisem zastosowania:
- *itertools* - użyta do grupowania punktów względem współrzędnej, 
- *time* - użyta do mierzenia czasu wykonywania algorytmów, 
- *numpy* - użyta do ułatwienia zapisu danych, losowania punktów, tasowania zbiorów. Również wszystkie funkcje matematyczne zostały zaczerpnięte z tej biblioteki,
- *matplotlib* - umożliwiła wizualizację działania algorytmów,
- *os* - użyta do obsługi systemu plików podczas zapisu i odczytu danych oraz animacji.
== Struktura plików
Kod źródłowy projektu został podzielony na moduły. \ \
Moduły realizujące rozwiązanie ćwiczenia znajdują się w katalogu *\/src\/*. Poniżej znajduje się lista modułów wraz z opisem każdego z nich:
- *tests.py* - zawiera generatory punktów losowych, oraz funkcję umożliwiającą przeprowadzenie analizy czasu działania zbioru algorytmów na zbiorach punktów generowanych przez zadany generator,
- *drawing.py* - pozwala na wprowadzanie zbioru punktów przez użytkownika, zawiera funkcje umożliwające wizualizację zbioru punktów oraz otoczki tego zbioru. Ponadto zawiera klasę _Visualization_ pozwalającą na wizualizację kroków algorytmu. Każdy z algorytmów posiada wersję wykorzystującą tą klasę do prezentacji graficznej poszczególnych kroków.
- *pozostałe pliki* - realizacje poszczególnych algorytmów wyznaczania otoczki wypukłej. W sekcji 3.3 przy opisie każdego z algorytmów znajduje się informacja, który plik zawiera jego kod źródłowy.\ \
Ponadto plik *main.py*, znajdujący się poza katalogiem *\/src\/*, został przygotowany w celu realizacji warstwy użytkownika opisanej w następnej sekcji dokumentacji.
= Realizacja ćwiczenia
== Dane wejściowe
Przyjmujemy, że zbiorem danych wejściowych jest zbiór punktów na płaszczyźnie. Punkty są krotkami zawierającymi dwie liczby zmiennoprzecinkowe reprezentujące ich współrzędne. Przyjmujemy, że w zbiorze punktów nie ma żadnych duplikatów (punktów o tych samych współrzędnych). Mogą natomiast wystąpić pary punktów o tej samej współrzędnej.
== Oczekiwany wynik działania algorytmów
Każdy z zaimplementowanych algorytmów ma w założeniu wyznaczyć otoczkę wypukłą punktów z danych wejściowych. Za poprawną otoczkę przyjmuje się listę punktów taką, że:
- punkty z tej listy są wierzchołkami wielokąta następującymi po sobie w kolejności przeciwnej do ruchu wskazówek zegara,
- wielokąt ten jest otoczką wypukłą zbioru danych wejściowych.
== Omówienie implementacji algorytmów
=== Elementy wspólne
==== Wyznacznik - _det_
Funkcja _det(a,b,c)_ obliczająca wyznacznik macierzy:
$ det(a,b,c) = mat(
  x_a, y_a, 1;
  x_b, y_b, 1;
  x_c, y_c, 1;) $
została wielokrotnie wykorzystana w zaimpementowanych algorytmach. 
Poprzez badanie znaku tego wyznacznika można określić orientację trzech następujących po sobie punktów. \
\
Z racji na niedokładność obliczeń, za każdym razem, gdy badano znak wartości funkcji _det_, użyto wartości $epsilon = 10^(-12)$ jako tolerancji dla $0$.\
==== Sortowanie z usuwaniem punktów współliniowych - _x_sort_
Funkcja _x_sort_ została zaimplementowana na potrzebę sortowania punktów względem ich współrzędnej _*x*_, która to funkcjonalność znajduje zastosowanie  w algorytmach: _*przyrostowym*_, _*górnej i dolnej otoczki*_ oraz *_dziel i rządź_*. \
\
Funkcja poza sortowaniem punktów dodatkowo grupuje punkty o tej samej współrzędnej _*x*_.
Jeżeli w danej grupie występują co najmniej 3 punkty funkcja dodatkowo usuwa ze zbioru wynikowego wszystkie punkty poza tymi o najmniejszej i największej współrzędnej *_y_*. Następnie łącząc grupy i zwracaja posortowaną listę.\
\
Złożoność takiego sortowania wynosi $O(n l o g(n))$, gdzie n to liczba punktów.
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
==== Prezentacja działania
Dopóki warunek wypukłości nie jest naruszony algorytm dodaje punkty jeden po drugim (rys. 1, rys. 2).
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/graham1.gif", width: 100%),
    caption: [dodanie punktu]
  ),
  figure(
    image("images/graham2.gif", width: 100%),
    caption: [dodanie punktu]
  ),)
Kiedy kąt wewnętrzny okazuje się być rozwarty po dodaniu punktu algorytm usuwa dodane punkty aż warunek wypukłości będzie spełniony (rys. 3, rys. 4).
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/graham3.gif", width: 100%),
    caption: [naruszenie warunku wypukłości]
  ),
  figure(
    image("images/graham4.gif", width: 100%),
    caption: [usunięcie punktu wewnętrznego]
  ),)
  \
W ten sposób algorytm buduje całą otoczkę.
==== Analiza złożoności obliczeniowej
Cały algorytm ma złożoność obliczeniową _O(nlog(n))_, gdzie $n$ to liczba punktów na płaszczyźnie. Najbardziej kosztownym etapem algorytmu jest sortowanie punktów - wykonuje się ono w czasie _O(nlog(n))_. Następny etap algorytmu jest iteracją po punktach i wymaga czasu $O(n)$. Algorytm Grahama jest bardzo uniwersalnym algorytmem o przewidywalnym czasie działania dla każdego zbioru danych.
=== Algorytm Jarvisa
Plik *jarvis.py*.
==== Przebieg algorytmu
Algorytm jest inaczej nazywany algorytmem _owijania prezentu_ (ang. _gift wrapping_). Podobnie jak algorytm Grahama (3.3.2) rozpoczyna działanie od znalezienia punktu *_lowest_point_* o najmniejszej pierwszej współrzędnej, lub - w przypadku remisu - o najmniejszych obu współrzędnych. Następnie algorytm znajduje następny punkt należący do otoczki z pomocą funkcji _det_ - iteruje po wszystkich punktach znajdując taki punkt *_best_*, dla którego wszystkie inne punkty leżą po lewej stronie odcinka (*_last_*, *_best_*), gdzie *_last_* jest ostatnim znalezionym punktem należącym do otoczki - początkowo _*lowest_point*_. Po przetworzniu wszystkich puntów punkt _*best*_ staje się punktem _*last*_ i jest dodawany do otoczki. Algorytm kroki te powtarza, aż znaleziony zostanie punkt startowy, co reprezentuje zamknięcie otoczki. 
==== Analiza złożoności obliczeniowej
Algorytm Jarvisa ma złożoność _O(nk)_, gdzie _n_ to liczba punktów na płaszczyźnie, oraz _k_ to liczba punktów należących do otoczki. Wynika ona z prostego faktu znajdowania jednego punktu należącego do otoczki w każdym kroku algorytmu, która objemuje iteracje po wszystkich punktach ze zbioru wejściowego. Faktyczny czas działania algorytmu może być nieprzewidywalny i jest bardzo wrażliwy na różne dane wejściowe - w oczywisty algorytm Jarvisa nie jest najlepszym wyborem do wyznaczania otoczek zbiorów punktów o potencjalnie wielu punktach należących do otoczki.
==== Prezentacja działania
Na rysunkach 5-8 zaprezentowano działanie algorytmu.
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/jarvis1.gif", width: 100%),
    caption: [sprawdzanie punktów jeden po drugim]
  ),
  figure(
    image("images/jarvis2.gif", width: 100%),
    caption: [algorym pamięta najodleglejszy w sensie biegunowym punkt]
  ),)
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/jarvis3.gif", width: 100%),
    caption: [wszystkie punkty zostały przetworzone]
  ),
  figure(
    image("images/jarvis4.gif", width: 100%),
    caption: [powtarzanie kroków dla nowego punktu otoczki]
  ),)
  \
W ten sposób algorytm buduje całą otoczkę.
=== Algorytm przyrostowy
Plik *incremental.py*.
==== Przebieg algorytmu
Algorytm najpierw sortuje punkty z użyciem funkcji _x_sort_.\ \ 
Algorytm tworzy pierwszą otoczkę na podstawie dwóch pierwszych punktów posortowanego zbioru. Następnie iteracyjnie dodaje każdy z pozostałych punktów do otoczki. Dołączanie punktu opiera się na znalezieniu stycznych do otoczki przechodzących przez ten punkt i usunięcie wszystkich punktów otoczki, które znajdowałyby się wewnątrz otoczki po dodaniu do niej rozważanego punktu.
\
\
Styczne znajdowane są z pomocą funkcji _det_.
==== Analiza złożoności algorytmu
Algorytm ma złożoność _O(nlog(n))_, gdzie _n_ to liczba punktów na płaszczyźnie. Samo sortowanie punktów zajmuje _O(nlog(n))_ czasu procesora. Podczas iteracyjnego dołączania punktów do otoczki każdy punkt jest dodawany do otoczki raz i maksymalnie raz z niej usuwany, złożoność tego kroku wynosi więc _O(n)_, a finalna złożoność algorytmu przyrostowego to faktycznie _O(nlog(n))_.
==== Prezentacja działania=
Tak długo jak nie występują punkty wewnętrzne algorytm dodaje każdy punkt w kolejności sortowania (rys. 9, rys. 10).
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/incremental1.gif", width: 100%),
    caption: [dodawanie punktu]
  ),
  figure(
    image("images/incremental2.gif", width: 100%),
    caption: [brak punktów wewnętrznych]
  ),)
W momencie wystąpienia punktów wewnętrznych algorytm usuwa wszystkie takie punkty (rys. 11, rys. 12).
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/incremental3.gif", width: 100%),
    caption: [dodawanie punktu]
  ),
  figure(
    image("images/incremental4.gif", width: 100%),
    caption: [punkty wewnętrzne usunięte z otoczki]
  ),)
  \
W ten sposób algorytm buduje całą otoczkę.

== Algorytm górnej i dolnej otoczki
Plik *monochain.py*.
==== Przebieg algorytmu
Algorytm rozpoczyna pracę od posortowania zbioru punktów z użyciem funkcji _x_sort_.\
\
Następnie algorytm iteracyjnie konstuuje górną otoczkę punktów. Początkowa górna otoczka składa się z dwóch pierwszych punktów w posortowanym zbiorze. Każdy kolejny punkt jest dodawany do górnej otoczki, po uprzednim usunięciu z niej wszystkich punktów, których obecność naruszyła by warunek wypukłości, który sprawdzany jest z użyciem funkcji _det_. Dolna otoczka wyznaczana jest analogicznie.
\
\
Ostatnim krokiem algorytmu jest połączenie górnej i dolnej otoczki z uwagą na warunek prawoskrętności otoczki.
==== Analiza złożoności obliczeniowej
Sortowanie punktów wykonywane jest w czasie _O(nlog(n))_, gdzie _n_ to liczba punktów na płaszczyźnie. Każdy punkt jest przetwarzany w iteracyjnej części algorytmu stałą liczbę razy. Finalna złożoność algorytmu górnej i dolnej otoczki to więc _O(nlog(n))_.
==== Prezentacja działania algorytmu
Na rysunkach 13, 14, 15 zaprezentowano kroki budowy dolnej otoczki. Górna otoczka jest budowana analogicznie i razem z dolną tworzy otoczkę wypukłą zbioru (rys. 16).
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/monochain1.gif", width: 100%),
    caption: [budowanie dolnej otoczki]
  ),
  figure(
    image("images/monochain2.gif", width: 100%),
    caption: [naruszenie warunku wypukłości]
  ),)
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/monochain3.gif", width: 100%),
    caption: [usunięcie punktów wewnętrznych]
  ),
  figure(
    image("images/monochain4.gif", width: 100%),
    caption: [otoczka wypukła będąca sumą otoczki górnej i dolnej]
  ),)
  \
=== Algorytm dziel i rządź
Plik *divide_and_conquer.py*.
==== Przebieg algorytmu
Algorytm opiera się na utworzeniu zbioru otoczek, które w sumie obejmują cały zbiór punktów wejściowych, oraz na późniejszym łączeniu ich w czasie stałym do momentu otrzymania jednej otoczki obejmującej cały zbiór.
\
\
Pierwszym krokiem jest posortowanie punktów z użyciem funkcji _x_sort_. Następnie tak posortowana lista jest dzielona na części. Każda z tych części jest listą kolejnych *_k_* punktów należących do posortowanej listy wejściowej, gdzie *_k_* jest małą stałą będącą parametrem algorytmu. Następnie dla każdego z tych podzbiorów punktów wyznaczana jest otoczka wypukła z użyciem algorytmu Grahama.
\
\
Tak powstałe sąsiednie otoczki są łączone poprzez znajdowanie stycznych z użyciem funkcji _det_. Łączenie to jest powtarzane do momentu otrzymania jednej otoczki będącej sumą wszystkich otoczek.
==== Analiza złożoności obliczeniowej
Samo sortowanie zbioru wejściowego wykonuje się w czasie _O(nlog(n))_. Wyznaczanie otoczek podzbiorów dla małej stałej *_k_* zajmuje stały czas O(k). Ponieważ ten krok powtarzany jest dla _n/k_ otoczek zajmuje on w sumie $O(k times n/k) = O(n)$ czasu procesora. Łączenie 2 otoczek zajmuje stały czas, a samych otoczek do połączenia jest $n/k$. Czas poświęcany na ten krok wynosi więc $O(n/k l o g(n/k)) = O(n l o g (n))$. Finalna złożoność algorytmu wynosi więc _O(nlogn_).
==== Prezentacja działania algorytmu
Na rysunkach 17-20 zaprezentowano wybrane kroki algorytmu, na których widać, jak otoczki łączą się. Połączenie wszystkich otoczek jest otoczką wypukłą zbioru.
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/div1.gif", width: 100%),
    caption: [początkowy stan dla k=2]
  ),
  figure(
    image("images/div2.gif", width: 100%),
    caption: [połączone otoczki]
  ),)
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/div3.gif", width: 100%),
    caption: [trzeci od końca krok algorytmu]
  ),
  figure(
    image("images/div4.gif", width: 100%),
    caption: [przedostatni krok algorytmu]
  ),)
  \
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
==== Prezentacja działania algorytmu
Na rysunkach 21-24 zaprezentowano wybranekroki algorytmu quickhull. Na czerwono zostały oznaczone odcinki, które na danym etapie algorytmu zostały przetworzone i na pewno należą do otoczki.
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/quickhull1.gif", width: 100%),
    caption: [rozpoczęcie rekurencji]
  ),
  figure(
    image("images/quickhull2.gif", width: 100%),
    caption: [rozbicie odcinka]
  ),)
#grid(
  columns: (1fr, 1fr),  // Two equal-width columns
  gutter: 1em,          // Space between the images
  figure(
    image("images/quickhull3.gif", width: 100%),
    caption: [jedna z gałęzi zakończyła rekurencję]
  ),
  figure(
    image("images/quickhull4.gif", width: 100%),
    caption: [stan otoczki na moment przetworzenia 3 z 4 odcinków startowych]
  ),)
  \

Przetworzenie ostatniego odcinka (rys. 24 - niebieski odcinek) skutkuje wyznaczeniem otoczki wypukłej.
