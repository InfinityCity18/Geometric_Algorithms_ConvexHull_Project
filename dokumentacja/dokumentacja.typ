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
  #text(size: 1.2em)[7 stycznia 2026]
]

#outline()

= Wstęp

Ćwiczenie polegało na implementacji algorytmów wyznaczania otoczki wypukłej zaprezentowanych na wykładzie. Zaimplementowane zostały algorytmy:
- *Grahama*,
- *Jarvisa*,
-  przyrostowy wyznaczania otoczki wypukłej (dalej *przyrostowy*)
- *górnej i dolnej otoczki* - zamiennie nazywany _monochain_ (ponieważ buduje x-monotoniczne łańcuchy),
- *dziel i rządź*,
- *quickhull*,
- *Chana*.
Powyższe algorytmy następnie przetestowano na uprzednio przygotowanych danych testowych oraz porównano ich działanie. Przygotowano wizualizację działania każdego z algorytmów.

= Szczegóły techniczne
== Dane sprzętowe
- *Architektura procesora*: x86_64
- *System operacyjny*: Fedora Linux 43
- *Środowisko*: NeoVim/Visual Studio Code
- *Język i wersja interpretera*: Python 3.14
- *Procesor*: 12th Gen Intel Core i5-12450H $times$ 12
== Użyte biblioteki
W projekcie wykorzystano funkcjonalności zarówno z biblioteki standardowej języka, jak i bibliotek zewnętrznych. Poniżej znajduje się lista importowanych modułów wraz z opisem zastosowania:
- *itertools* - użyto do grupowania punktów względem współrzędnej, 
- *time* - użyto do mierzenia czasu wykonywania algorytmów, 
- *numpy* - użyto do ułatwienia zapisu danych, losowania punktów, tasowania zbiorów. Również wszystkie funkcje matematyczne zostały zaczerpnięte z tej biblioteki,
- *matplotlib* - umożliwia wizualizację działania algorytmów,
- *os* - użyto do obsługi systemu plików podczas zapisu i odczytu danych oraz animacji.
== Struktura plików
Kod źródłowy projektu został podzielony na moduły. \ \
Moduły realizujące rozwiązanie ćwiczenia znajdują   się w katalogu *\/src\/*. Poniżej znajduje się lista modułów wraz z opisem każdego z nich:
- *tests.py* - zawiera generatory punktów losowych, oraz funkcję umożliwiającą przeprowadzenie analizy czasu działania zbioru algorytmów na zbiorach punktów generowanych przez zadany generator. Opisy poszczególnych generatorów znajdują się w sekcji,
- *drawing.py* - pozwala na wprowadzanie zbioru punktów przez użytkownika, zawiera funkcje umożliwające wizualizację zbioru punktów oraz otoczki tego zbioru. Ponadto zawiera klasę _Visualization_ pozwalającą na wizualizację kroków algorytmu. Każdy z algorytmów posiada wersję wykorzystującą tą klasę do prezentacji graficznej poszczególnych kroków.
- *\_\_init\_\_.py* - plik konieczny by katalog był rozpoznawany przez język Python jako moduł,
- *pozostałe pliki* - realizacje poszczególnych algorytmów wyznaczania otoczki wypukłej. W sekcji 3.3 przy opisie każdego z algorytmów znajduje się informacja, który plik zawiera jego kod źródłowy.\ \
Ponadto plik *main.py*, znajdujący się poza katalogiem *\/src\/*, został przygotowany w celu realizacji warstwy użytkownika opisanej w następnej sekcji dokumentacji.
== Warstwa użytkownika
Program należy uruchomić używając pliku *main.py*. Plik wykorzystuje funkcjonaności kodu źródłowego do prezentacji działania algorytmów wyznaczania otoczki wypukłej. Całość interfejsu użytkownika realizowana jest przez konsolę. Poprzez wybór różnych opcji użytkownik może:
- przeprowadzić analizę czasu działania algorytmów dla różnych zbiorów danych,
- wprowadzić własny zbiór punktów,
- wygenerować zbiór punktów z użyciem generatora z pliku *tests.py*,
- wczytać zbiór punktów z pliku,
- zapisać zbiór punktów do pliku,
- zapisać wynik działania wybranego algorytmu - otoczkę wypukłą zbioru punktów,
- wyświetlić wizualizację działania wybranego algorytmu w oknie _matplotlib_,
- zapisać wizualizację działania wybranego algorytmu do pliku _.gif_.
Jeżeli program jest uruchamiany z poziomu *main.py*:
- zbiory punktów zapisywane są w katalogu *\/data\/* (są również z niego wczytywane),
- otoczki wypukłe zapisywane są w katalogu *\/hulls\/*,
- wizualizacje działania algorytmów zapisywane są w katalogu *\/gifs\/*.
= Realizacja ćwiczenia
== Dane wejściowe
Przyjmujemy, że zbiorem danych wejściowych jest zbiór punktów na płaszczyźnie. Punkty są krotkami zawierającymi dwie liczby zmiennoprzecinkowe reprezentujące ich współrzędne. Przyjmujemy, że w zbiorze punktów nie ma żadnych duplikatów (punktów o tych samych współrzędnych). Mogą natomiast wystąpić pary punktów o tej samej jednej ze współrzędnych.
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
  x_c, y_c, 1;
  delim: "|") $
została wielokrotnie wykorzystana w zaimplementowanych algorytmach. 
Poprzez badanie znaku tego wyznacznika można określić orientację trzech następujących po sobie punktów. \
Z racji na niedokładność obliczeń, za każdym razem, gdy badano znak wartości funkcji _det_, użyto wartości $epsilon = 10^(-12)$ jako tolerancji dla $0$.\
==== Sortowanie z usuwaniem punktów współliniowych - _x_sort_
Funkcja _x_sort_ została zaimplementowana na potrzebę sortowania punktów względem ich współrzędnej _*x*_, która to funkcjonalność znajduje zastosowanie  w algorytmach: _*przyrostowym*_, _*górnej i dolnej otoczki*_ oraz *_dziel i rządź_*.
Funkcja poza sortowaniem punktów dodatkowo grupuje punkty o tej samej współrzędnej _*x*_.
Jeżeli w danej grupie występują co najmniej 3 punkty funkcja dodatkowo usuwa ze zbioru wynikowego wszystkie punkty poza tymi o najmniejszej i największej współrzędnej *_y_*. Następnie łącząc grupyzwraca posortowaną listę. Złożoność takiego sortowania wynosi $O(n l o g(n))$, gdzie n to liczba punktów.
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
#pagebreak()
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
#pagebreak()
=== Algorytm Jarvisa
Plik *jarvis.py*.
==== Przebieg algorytmu
Algorytm jest inaczej nazywany algorytmem _owijania prezentu_ (ang. _gift wrapping_). Podobnie jak algorytm Grahama (3.3.2) rozpoczyna działanie od znalezienia punktu *_lowest_point_* o najmniejszej pierwszej współrzędnej, lub - w przypadku remisu - o najmniejszych obu współrzędnych. Następnie algorytm znajduje następny punkt należący do otoczki z pomocą funkcji _det_ - iteruje po wszystkich punktach znajdując taki punkt *_best_*, dla którego wszystkie inne punkty leżą po lewej stronie odcinka (*_last_*, *_best_*), gdzie *_last_* jest ostatnim znalezionym punktem należącym do otoczki - początkowo _*lowest_point*_. Po przetworzniu wszystkich puntów punkt _*best*_ staje się punktem _*last*_ i jest dodawany do otoczki. Algorytm kroki te powtarza, aż znaleziony zostanie punkt startowy, co reprezentuje zamknięcie otoczki. 
==== Analiza złożoności obliczeniowej
Algorytm Jarvisa ma złożoność _O(nk)_, gdzie _n_ to liczba punktów na płaszczyźnie, oraz _k_ to liczba punktów należących do otoczki. Wynika ona z prostego faktu znajdowania jednego punktu należącego do otoczki w każdym kroku algorytmu, która objemuje iteracje po wszystkich punktach ze zbioru wejściowego. Faktyczny czas działania algorytmu może być nieprzewidywalny i jest bardzo wrażliwy na różne dane wejściowe - w oczywisty algorytm Jarvisa nie jest najlepszym wyborem do wyznaczania otoczek zbiorów punktów o potencjalnie wielu punktach należących do otoczki.
#pagebreak()
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
#pagebreak()
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

#pagebreak()
==== Prezentacja działania
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

#pagebreak()
=== Algorytm górnej i dolnej otoczki
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
#pagebreak()
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
#pagebreak()
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
Samo sortowanie zbioru wejściowego wykonuje się w czasie _O(nlog(n))_. Wyznaczanie otoczek podzbiorów dla małej stałej *_k_* zajmuje stały czas O(k). Ponieważ ten krok powtarzany jest dla _n/k_ otoczek zajmuje on w sumie $O(k times n/k) = O(n)$ czasu procesora. Łączenie 2 otoczek zajmuje stały czas, a samych otoczek do połączenia jest $n/k$. Czas poświęcany na ten krok wynosi więc $O(n/k log n/k) = O(n log n)$. Finalna złożoność algorytmu wynosi więc _O(nlogn_).
#pagebreak()
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
#pagebreak()
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
Każde rekurencyjne wywołanie fukcji *_rec_hull_* iteruje się po zbiorze punktów, którego rozmiar jest proporcjonalny do rozmiaru zbioru wejściowego. Ilość takich wywołań w pełni zależy od charakterystyki zbioru wejściowego. W pesymistycznym przypadku w każdym wywołaniu *_rec_hull_* jedyny usuwany punkt jest tym najbardziej odległym od rozpatrywanego, a pozostałe punkty leżą w pełni na jednej gałęzi rekurecji - wtedy następuje efektywnie identyczne w sensie czasu pracy wywołanie funkcji *_rec_hull_* i złożoność algorytmu wynosi $O(n^2)$.
Realistycznie jednak, zakładając względnie równomierne rozłożenie punktów, przy każdym "powiększaniu" otoczki przez funkcję *_rec_hull_* punkty należące do obszaru proporcjonalnego do długości odcinka są usuwane, a pozostałe punkty dzielone są między dwie gałęzie rekurecji. Zamortyzowana złożoność obliczeniowa wynosi więc _O(nlog(n))_.
#pagebreak()
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
#pagebreak()

=== Algorytm Chana
Plik *chan.py*.
==== Przebieg algorytmu
Algorytm zakłada, że znamy rozmiar otoczki $m$, więc algorytm będzie zwiększał zmienną $t$ począwszy od zera, przypisując $m := min(2^(2^t), n)$ i wywołując funkcję _*step_chan*_, aż do znalezienia otoczki.
Funkcja _*step_chan*_ przyjmuje zbiór punktów oraz rozmiar otoczki $m$. Następnie dzieli zbiór na $ceil(n/m)$ grup o rozmiarze $m$ i wyznacza dla każdej otoczkę algorytmem Grahama.
Algorytm rozpoczyna od punktu najbardziej po prawej, i stara się znaleźć punkt maksymalizujący kąt tj. taki, że po lewej stronie prostej od poprzedniego punktu do szukanego znajdują się wszystkie inne punkty zbioru, tak jak w algorytmie Jarvisa, tylko zamiast sprawdzać wszystkie punkty, algorytm znajduje punkty przecinane przez prawe styczne otoczek. Jeżeli nie uda się znaleźć otoczki o rozmiarze $m$, funkcja zwraca _None_, a główna pętla zwiększa wartość zmiennej $t$.

==== Analiza złożoności obliczeniowej
==== Prezentacja działania algorytmu
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

== Przygotowane generatory zbiorów testowych
Plik *tests.py*.
=== generate_uniform_points
Generuje zbiór *n* losowych punktów leżących w obszarze [*left*,*right*] $times$ [*left*,*right*], gdzie *left*, *right* oraz *n* to parametry generatora.
\ \
Poniżej, na rysunku 25, znajduje się wizualizacja przykładowego zbioru punktów wygenerowana z użyciem generatora *generate_uniform_points* i parametrów *n* = 100, *left* = -100, *right* = 100.
#figure(
    image("images/uniform.png", width: 40%),
    caption: [przykładowy zbiór punktów]
  ) 
=== generate_circle_points
Generuje zbiór *n* losowych punktów leżących na kole o środku w punkcie *O* oraz promieniu *R*, gdzie *O*, *R* oraz *n* to parametry generatora.
\ \
Poniżej, na rysunku 26, znajduje się wizualizacja przykładowego zbioru punktów wygenerowana z użyciem generatora *generate_circle_points* i parametrów *n* = 50, *O* = (0,0), *R* = 100.
#figure(
    image("images/circle.png", width: 40%),
    caption: [przykładowy zbiór punktów]
  )
=== generate_zigzag_points
Generuje zbiór *n* losowych punktów leżących na prostokącie o środku w początku układu współrzędnych, oraz o długościach boków *width* oraz *height*, które są parametrami generatora. Punkty dodatkowo otoczone są naprzemienną obramówką punktów, tak jak widać na rysunku 27. Szerokość obramówki definiuje parametr *amplitude*, a częstość punktów na niej parametr *period*.
\ \
Poniżej, na rysunku 27, znajduje się wizualizacja przykładowego zbioru punktów wygenerowana z użyciem generatora *generate_zigzag_points* i parametrów *n* = 5, *width* = 200, *height* = 200, *amplitude* = 10, *period* = 10.
#figure(
    image("images/zigzag.png", width: 40%),
    caption: [przykładowy zbiór punktów]
  )
=== generate_square_points
Generuje zbiór *n* losowych punktów leżących na kwadracie o środku w początku układu współrzędnych i o boku długości *a*, gdzie *a* to parametr generatora.
\ \
Poniżej, na rysunku 28, znajduje się wizualizacja przykładowego zbioru punktów wygenerowana z użyciem generatora *generate_square_points* i parametrów *n* = 50, *a* = 100.
#figure(
    image("images/square.png", width: 40%),
    caption: [przykładowy zbiór punktów]
  )
=== generate_x_square_points
Generuje zbiór *n* losowych punktów leżących na kwadracie o środku w początku układu współrzędnych i o boku długości *a*, lub na jego przekątnych gdzie, *a* to parametr generatora. Ponadto generator dodaje do zbioru wynikowego 4 punkty będące wierzchołkami kwadratu.
\ \
Poniżej, na rysunku 28, znajduje się wizualizacja przykładowego zbioru punktów wygenerowana z użyciem generatora *generate_x_square_points* i parametrów *n* = 50, *a* = 100.
#figure(
    image("images/x_square.png", width: 40%),
    caption: [przykładowy zbiór punktów]
  )
== Testy algorytmów na przygotowanych zbiorach
Z użyciem pliku *main.py* przeprowadzono analizę czasu działania algorytmów dla zbiorów punktów o różnych licznościach wygenerowanych przez generatory opisane w sekcji 3.4. Wyniki i wnioski dla każdego z generatorów znajdują się poniżej. 
#pagebreak()
=== Wyniki dla generatora generate_uniform_points
Generator *generate_uniform_points* jest najprostszym z generatorów, analiza czasów działania algorytmów na zbiorach wygenerowanych przez niego może dać dobre pojęcie o prędkości każdego z algorytmów dla zbiorów danych o nieznanej charakterystyce (nie da się jednoznacznie stwierdzić ile punktów należy do otoczki, ani ile występuje punktów współliniowych). 
#set table(align: center + horizon)
#show table: set par(justify: false)
#show table.cell.where(x: 0).or(table.cell.where(y:0)): strong
#{
  show table.cell: set text(size: 10pt)
  let t1 = csv("tables/uniform.csv")
  table(
    columns: 8,
    ..t1.flatten()
  )
}
#align(center)[Tabela 1: czasy działania poszczególnych algorytmów na zbiorach punktów wygenerowanych przez *generate_uniform_points*]
#figure(
    image("images/diag_uniform.png", width: 60%),
    caption: [wykres na podstawie danych z tabeli 1]
  )
Czasy działania algorytmów zostały przedstawione w tabeli 1. Najszybszy okazał się algorytm *górnej i dolnej otoczki* (monochain). Zdecydowanie najwolnieszy był algorytm *Chana*, pomimo jego teoretycznie największej asymptotycznej prędkości. Wynika to najprawdopodobnej z faktu, że stała nie brana pod uwagę w złożoności $O(n l o g(k))$ jest bardzo wysoka i dopiero dla znacznie liczniejszych zbiorów danych rożnica byłaby znacząca. Jednakże jak widać na rysunku 30 dla tego generatora liczba punktów musiałaby być znacznie zbyt duża, by algorytm okazał się szybszy na sprzęcie, na którym był testowany.
#pagebreak()
=== Wyniki dla generatora generate_circle_points
Każdy punkt należący do zbioru wygenerowanego przez generator *generate_circle_points* jest należy do otoczki wypukłej tego zbioru. Przez to algorytmy *Jarvisa* oraz *Chana* powinny działać w teorii dłużej na takich zbiorach. Przeprowadzono stosowne testy i wyniki przedstawiono w tabeli 2.
#show table: set par(justify: false)
#show table.cell.where(x: 0).or(table.cell.where(y:0)): strong
#{
  show table.cell: set text(size: 10pt)
  let t1 = csv("tables/circle.csv")
  table(
    columns: 8,
    ..t1.flatten()
  )
}
#align(center)[Tabela 2: czasy działania poszczególnych algorytmów na zbiorach punktów wygenerowanych przez *generate_circle_points*]
#figure(
    image("images/diag_circle.png", width: 60%),
    caption: [wykres na podstawie danych z tabeli 2]
  )
Z danych z tabeli 2, jak i z wykresu na rysunku 35 jasno wynika pogorszenie się złożoności algorytmów *Jarvisa* oraz *Chana*. Algorytm *Jarvisa* zdegradował do złożoności $O(n^2)$ i nawet na zbiorach o małej liczności jego czas pracy był bardzo długi. Podobnie algorytm *Chana*, którego złożoność zdegradowała do $O(n l o g(n))$ okazał się asymptotycznie wolniejszy niż w przypadku zbiorów wygenerowanych przez *generate_uniform_points*.
#pagebreak()
=== Wyniki dla generatora generate_zigzag_points
Ze względu na obramówkę każdy zbiór punktów wygenerowanych przez *generate_zigzag_points* ma dokładnie 8 punktów należących do swojej otoczki wypukłej. Dzięki temu algorytmy Jarvisa oraz Chana powinny osiągnąć znacznie lepsze czasy działania niż dla zbiorów nie cechujących się własnością stałej liczby punktów otoczki. Wyniki stosownych testów zaprezentowano w tabeli 3 oraz na wykresie widocznym na rysunku 36.
#show table: set par(justify: false)
#show table.cell.where(x: 0).or(table.cell.where(y:0)): strong
#{
  show table.cell: set text(size: 10pt)
  let t1 = csv("tables/zigzag.csv")
  table(
    columns: 8,
    ..t1.flatten()
  )
}
#align(center)[Tabela 3: czasy działania poszczególnych algorytmów na zbiorach punktów wygenerowanych przez *generate_zigzag_points*]
#figure(
    image("images/diag_zigzag.png", width: 60%),
    caption: [wykres na podstawie danych z tabeli 3]
  )
Wyniki testów widoczne w tabeli 3 potwierdzają hipotezę o korzystności danych o małej liczbie punktów otoczki dla algorytmów *Jarvisa* oraz *Chana*. Porównując je z wynikami dl a generatora *generate_uniform_points*, gdzie liczba punktów w otoczce nie jest stała i może rosnąć można zauważyć, że wszystkie algorytmy poza wymienionymi powyżej osiągają podobne czasy działania (czasami nieznacznie większe, ze względu na dodanie punktów obramówki), natomiast algorytmy *Chana* oraz *Jarvisa* radzą sobie szybciej.
#pagebreak()
=== Wyniki dla generatora generate_square_points
Otoczka każdego zbioru punktów wygenerowanego przez *generate_square_points* ma 4 punkty (wykluczając przypadki zdegradowane np. gdy żaden punkt nie znajduje się na którymś boku kwadratu). Ponownie spodziewamy się poprawy czasu działania algorytmów *Chana* i *Jarvisa*. Wyniki testów znajdują się w tabeli 4.
#show table: set par(justify: false)
#show table.cell.where(x: 0).or(table.cell.where(y:0)): strong
#{
  show table.cell: set text(size: 10pt)
  let t1 = csv("tables/square.csv")
  table(
    columns: 8,
    ..t1.flatten()
  )
}
#align(center)[Tabela 4: czasy działania poszczególnych algorytmów na zbiorach punktów wygenerowanych przez *generate_square_points*]
#figure(
    image("images/diag_square.png", width: 60%),
    caption: [wykres na podstawie danych z tabeli 4]
  )
  Poza ponownym potwierdzeniem tezy o liniowej złożoności algorytmów *Jarvisa* oraz *Chana* dla zbiorów o stałej liczbie punktów otoczki, z tabeli 4 można wyciągnąć parę ciekawych wniosków:
- w przybliżeniu prostokątny kształt i stały rozmiar (4 punkty) podotoczek tworzonych podczas działania algorytmu *dziel i rządź* pozwolił na szybkie ich łączenie i algorytm osiągnął czas w przybliżeniu dwukrotnie mniejszy niż dla zbiorów tworzonych przez *generate_uniform_points* i *generate_zigzag_points*,
- algorytm *górnej i dolnej otoczki*, dzięki charakterystyce danych względnie rzadko musi usuwać punkty podczas budowania otoczki. Podobnie jak *dziel i rządź* działał około 2 razy szybciej niż dla generatora *generate_uniform_points*.
=== Wyniki dla generatora generate_x_square_points
Generator *generate_x_square_points* różni się od *generate_square_points* głównie przez to że, otoczka każdego wygenerowanego przez niego zbioru punktów ma dokładnie 4 punkty.
Wyniki testów na tym generatorze przedstawiono w tabeli 5 oraz na wykresie widocznym na rysunku 38.
#show table: set par(justify: false)
#show table.cell.where(x: 0).or(table.cell.where(y:0)): strong
#{
  show table.cell: set text(size: 10pt)
  let t1 = csv("tables/x_square.csv")
  table(
    columns: 8,
    ..t1.flatten()
  )
}
#align(center)[Tabela 5: czasy działania poszczególnych algorytmów na zbiorach punktów wygenerowanych przez *generate_x_square_points*]
#figure(
    image("images/diag_x_square.png", width: 60%),
    caption: [wykres na podstawie danych z tabeli 5]
  )
Co wynika z tabeli 5, algorytm *Jarvisa* cechuje się liniowością dla stałej liczby punktów otoczki - w porównaniu do generatora *generate_square_points* (gdzie otoczki mają 8 punktów) wypadł około 2 razy szybciej. Podobnie algorytm *Chana* osiągnął znacznie mniejszy czas. Zestawiając to z faktem, że liczba punktów w zbiorze nie zmieniła się dowodzi to, że teoretyczna złożoność algorytmu Chana $O(n log(k))$ znajduje odzwierciedlenie w rzeczywistości, a algorytm został poprawnie zaimplementowany. Podotoczki występujące w algorytmie *dziel i rządź* nie miały już takiego samego, korzystnego kształtu jak w przypadku generatora *generate_square_points* i odbiło się to znacząco na jego czasie działania pomimo takiej samej liczby punktów. Podobnie algorytm *górnej i dolnej otoczki* ponownie osiągnął czas pracy podobny to tego dla generatora *generate_uniform_points*.
#pagebreak()
=== Wnioski
Różnice w asymptotycznej złożoności algorytmów Chana i Jarvisa względem pozostałych algorytmów zostały jasno nakreślone podczas wykonywania testów. Na podstawie podobnych kształtów wykresów czasu pracy pozostałych algorytmów (rys. 34-38) można wnioskować, że ich złożonośc jest taka sama i wynosi $O(n log(n))$.\ \
Sama bezwzględna wartość czasu działania dla wszystkich zbiorów testowych była największa dla algorytmu *Chana*, choć jego teoretyczna złożoność obliczeniowa została potwierdzona poprzez porównanie wyników testów na zbiorze 4 oraz 5. \ \

Najszybsze na ogół okazały się algorytmy: *górnej i dolnej otoczki*, *przyrostowy* oraz *quickhull*. W szczególności algorytmy *Grahama* oraz *quickhull* wykazały się dużą niewrażliwością na charakterystykę danych wejściowych i dla podobnej liczby losowych punktów zawsze działały w podobym czasie.
= Podsumowanie
Kod przygotowany na potrzeby wykonania ćwiczenia pozwolił na analizę i porównanie działania algorytmów wyznaczania otoczki wypukłej zbioru punktów na płaszczyźnie. Przygotowana funkcjonalność tworzenia wizualizacji w jasny i przejrzysty sposób przedstawia metodykę działania każdego z algorytmów, a konsekwencje wynikające z różnic między nimi ujawniły się podczas wykonywania testów opisanych w sekcji 3.5.


W szczególności potwierdzone zostały teoretycznie złożoności algorytmów *Jarvisa* i *Chana*, które odbiegają od złożoności pozostałych algorytmów. \ \

Wyniki testów oraz wizualizacje potwierdzają poprawność zaimplementowanych algorytmów.
= Bibliografia
- slajdy z wykładu,
- materiały do laboratoriów, 
- https://en.wikipedia.org/wiki/Convex_hull_algorithms#Akl%E2%80%93Toussaint_heuristic (7.01.2026),
- https://en.wikipedia.org/wiki/Gift_wrapping_algorithm (7.01.2026),
- https://en.wikipedia.org/wiki/Graham_scan (7.01.2026),
- https://en.wikipedia.org/wiki/Quickhull (7.01.2026),
- https://gist.github.com/tixxit/252229 (7.01.2026),
- https://www.youtube.com/watch?v=O_K5_whYhoU (7.01.2026),
- https://www.youtube.com/watch?v=NH6WbP3lDac (7.01.2026).


