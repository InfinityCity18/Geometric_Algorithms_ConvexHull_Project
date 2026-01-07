#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import cosmos.clouds: *
#show: show-theorion
#show: codly-init.with()

#codly(
  languages: (
    rust: (name: "Python", color: rgb("#164e9b")),
  )
)

#set text(lang: "pl")
#set par(justify: true)
#let complexity_rect(body) = {
  align(center)[#rect(stroke: none, fill: rgb("#e5e8eb"), height: 2em, inset: 1em, outset: 0.3em, radius: 0.5em)[#align(body, center + horizon)]]
}

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  //config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,),
  ),  // freeze theorem counter for animation
  config-info(
    title: [Otoczka wypukła dla zbioru punktów w przestrzeni dwuwymiarowej],
    subtitle: [Algorytmy Geometryczne],
    author: [Remigiusz Babiarz, Jakub Własiewicz],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#slide[
  #align(center)[
    #image("Znak_graficzny_AGH.svg",height: 47%)
    #text(
      [Otoczka wypukła dla zbioru punktów w przestrzeni dwuwymiarowej],
      size: 1.3em,
      weight: "semibold",
      fill: rgb("#0b3c4d"),
    )

    #text(
      [Algorytmy Geometryczne],
      size: 1.1em,
      fill: rgb("#555"),
    )

    #text(
      [Remigiusz Babiarz · Jakub Własiewicz],
      size: 0.95em,
    )
  ]
]

== Plan prezentacji <touying:hidden>

#components.adaptive-columns(outline(depth: 2, title: none, indent: 1em))

= Otoczka wypukła

== Definicja

#slide(composer: (1.03fr, 1fr), repeat: 3, self => [
  #v(3em)
  #align(horizon)[
*Otoczką wypukłą* zbioru punktów nazywamy najmniejszy wielokąt wypukły zawierający ten zbiór. Będziemy oznaczać liczbę punktów zbioru wejściowego jako *$n$*, a liczbę punktów otoczki jako *$h$*.]], self => [
#let (uncover, only) = utils.methods(self)
#move(dy: 2.5em, dx: 1.5em)[#cetz-canvas(length: 14em, {
  import cetz.draw: *
  let self = utils.merge-dicts(
      self,
      config-methods(cover: utils.method-wrapper(hide.with(bounds: true))),
    )
  let (uncover,) = utils.methods(self)
  let points = ((-0.153254445279432, 0.10015381314761651), (-0.153254445279432, 0.10015381314761651), (0.4915945620083575, 0.31649925931559775), (0.005808309851556004, -0.24167199179779408), (0.1476750914548699, 0.16938435592137058), (0.4486046281891716, 0.022269452527143185), (-0.4197920349583849, -0.13782617763716298), (-0.2736262599731527, 0.2775570790053612), (0.24225294585707902, 0.42034507347622885), (-0.2048423658624552, 0.4419796180930269), (-0.4713799555414081, 0.16938435592137058), (0.16917005836446286, -0.05561490809333014), (-0.041480617349548554, -0.08590327055684743));
  let hull = ((0.005808309851556004, -0.24167199179779408), (0.4486046281891716, 0.022269452527143185), (0.4915945620083575, 0.31649925931559775), (0.24225294585707902, 0.42034507347622885), (-0.2048423658624552, 0.4419796180930269), (-0.4713799555414081, 0.16938435592137058), (-0.4197920349583849, -0.13782617763716298))
  let bad_hull = ((0.005808309851556004, -0.24167199179779408), (0.4486046281891716, 0.022269452527143185), (0.1476750914548699, 0.16938435592137058),(0.4915945620083575, 0.31649925931559775), (0.24225294585707902, 0.42034507347622885), (-0.2048423658624552, 0.4419796180930269), (-0.4713799555414081, 0.16938435592137058), (-0.4197920349583849, -0.13782617763716298))

  uncover("2", {
  line(..hull, close: true)
  })

  uncover("3", {
  fill(none)
  line(..bad_hull, close: true)
  line((0.4486046281891716, 0.022269452527143185), (0.4915945620083575, 0.31649925931559775), stroke: (paint: red, thickness: 5pt))
  })

  fill(black)
  for point in points {
    circle(point, radius: 0.2em, fill: green)
  }

  uncover("3", {
    line((-0.5,-0.3), (0.5,0.5), stroke: (paint: red, thickness: 10pt))
    line((0.5,-0.3), (-0.5,0.5), stroke: (paint: red, thickness: 10pt))
    content((0,0.1), move(dy: -6.5em)[#text(red)[Nie jest wypukła!]])
  })

  })]
]
)

== Poprawność

#slide(repeat: 2, self => [

  #let (uncover, only) = utils.methods(self)

  Otoczkę uznajemy za poprawną jeżeli jej wierzchołki są zadane w kierunku przeciwnym lub zgodnym do ruchu wskazówek zegara. W dodatku, do otoczki *nie zaliczamy wewnętrznych punktów współliniowych*.

  #only(1)[#align(center + horizon)[#cetz-canvas(length: 6em,{
    import cetz.draw: *

    let points = ((0,0), (0, 0.51),(0,1), (0.70, 1.0),(1,1), (1,0.5),(1,0), (0.44,0))

    for point in points {
      circle(point, radius: 0.21em, fill: green)
    }

  })]]

  #only(2)[#align(center + horizon)[#cetz-canvas(length: 6em,{
    import cetz.draw: *

    let points = ((0,0), (0, 0.51),(0,1), (0.70, 1.0),(1,1), (1,0.5),(1,0), (0.44,0))
    let correct = ((2,0), (2,1), (3,1), (3,0))

    line(..points, close: true, stroke: (paint: blue, thickness: 4pt))
    for point in points {
      circle(point, radius: 0.21em, fill: blue, stroke: blue)
    }
    line(..correct, close: true, stroke: (paint: blue, thickness: 4pt))
    for point in correct {
      circle(point, radius: 0.21em, fill: blue, stroke: blue)
    }

    line((0.1,-0.2), (0.9,1.2), stroke: (paint: red, thickness: 6pt))
    line((0.9,-0.2), (0.1,1.2), stroke: (paint: red, thickness: 6pt))

    set-style(mark: (end: ">"))
    line((1.35,1.35), (0.8,0.6), stroke: (thickness: 7pt))
    line((1.65,1.35), (2.2,0.6), stroke: (thickness: 7pt))

  })]]

  ])

= Algorytmy

== Przyrostowy

=== Działanie algorytmu
Algorytm najpierw sortuje punkty względem współrzędnej $x$, a następnie wybiera dwa pierwsze punkty, będące początkową otoczką.
Następnie iteracyjnie dodaje kolejne punkty do otoczki, dokonane jest to poprzez znalezienie *stycznych do otoczki przechodzących przez kolejne punkty* i odpowiednie usuwanie punktów wewnątrz niej.

\
#complexity_rect([Złożoność czasowa algorytmu to $O( n log n)$])

#include "anim/incremental.typ"

== Grahama

=== Działanie algorytmu

Algorytm wyszukuje najniższy punkt względem $y$, sortuje punkty na podstawie kąta jaki tworzy odcinek przez najniższy punkt oraz kolejny punkt z osią $O X$. Usunięte są również punkty współliniowe. Tworzy stos, dla każdego punktu usuwa punkty ze stosu aż dwa ostatnie z wybranym punktem przestaną tworzyć skręt w prawo i dodaje ten punkt na stos.

\
#complexity_rect([Złożoność czasowa algorytmu to $O( n log n)$])

#include "anim/graham.typ"

== Jarvisa

=== Działanie algorytmu

Algorytm rozpoczyna od znalezienia najniższego punktu, następnie iterując po wszystkich punktach, znajduje taki którego odcinek tworzony z ostatnim punktem otoczki spełnia warunek, że wszystkie punkty znajdują się po jego lewej stronie i dodaje go do otoczki. Algorytm kontynuuje do momentu spotkania początkowego punktu.

\
#complexity_rect([Złożoność czasowa algorytmu to $O( n h )$])

#include "anim/jarvis.typ"

== Górna i dolna otoczka

=== Działanie algorytmu

Algorytm sortuje punkty względem współrzędnej $x$.
Pierwsze dwa punkty są początkiem górnej otoczki, iteracyjnie dodajemy kolejne punkty do niej, zachowując warunek wypukłości, podobnie jak w algorytmie Grahama.
Analogicznie tworzymy dolną otoczkę, ostatecznie łącząc je w jedną, wynikową otoczkę.

\
#complexity_rect([Złożoność czasowa algorytmu to $O( n log n)$])

#include "anim/monochain.typ"

== Quickhull

=== Działanie algorytmu

Algorytm wyznacza 4 skrajne punkty zbioru, tworząc wielokąt. Usuwane są wszystkie punkty wewnątrz tego wielokąta, a następnie na każdym z boków wywoływana jest rekurencyjna funkcja, która tworzy trójkąt tworzony przez dany bok jako podstawę oraz najbardziej oddalony od niej punkt znajdujący się po konkretnej stronie. Zwracamy ten najdalszy punkt oraz najdalsze punkty zwrócone poprzez rekurencyjne wywołanie na dwóch pozostałych bokach trójkąta.
\
\
#complexity_rect([Złożoność czasowa algorytmu to $O( n log n)$])

#include "anim/quickhull.typ"

== Dziel i rządź

=== Działanie algorytmu
Algorytm sortuje punkty względem współrzędnej $x$, następnie dzieli zbiór na grupy względem mediany, aż do momentu gdy liczebność każdej z nich będzie mniejsza lub równa parametrowi algorytmu $k$. Algorytm Grahama wyznacza otoczkę dla każdej z grup, dzięki czemu możemy połączyć wszystkie mniejsze otoczki w jedną, wynikową. Łączenie sąsiednich otoczek polega na znajdowaniu stycznych.

\
#complexity_rect([Złożoność czasowa algorytmu to $O( n log n)$])

#include "anim/divide_and_conquer.typ"

== Chana

=== Działanie algorytmu
Algorytm łączy algorytmy Grahama i Jarvisa, zakładamy, że rozmiar otoczki będzie równy $m$, dzielimy zbiór na grupy o rozmiarze $m$ i wyznaczamy ich otoczki algorytmem Grahama. Następnie znajdujemy skrajny punkt będący początkiem otoczki i szukamy wsród tych otoczek taki punkt, który maksymalizuje kąt. Robimy tak maksymalnie $m$ razy. Ponieważ próba może się nie powieść, wywołujemy algorytm ustalając $m := min(2^(2^t), n)$, gdzie początkowo $t = 0$, do otrzymania prawidłowej otoczki.
#complexity_rect([Złożoność czasowa algorytmu to $O( n log h)$])

#include "anim/chan.typ"

= Zbiory testowe

== Wybrane zbiory testowe

Aby sprawdzić poprawność oraz wydajność zaimplementowanych algorytmów, użyliśmy następujących zbiorów testowych:

- *Zbiór 1* - punkty losowe z zakresu $[-100, 100]$,
- *Zbiór 2* - punkty na okręgu o promieniu $100$,
- *Zbiór 3* - punkty wewnątrz kwadratu otoczonego obramówką kszałtu zygzaka
- *Zbiór 4* - punkty na obramówce kwadratu
- *Zbiór 5* - punkty na obramówce kwadratu oraz jego przekątnych

---

#let w = 196pt
#align(center)[
#grid(align: center, rows: 2)[
#grid(columns: 3)[
  #image("images/testset1.svg", width: w)
][
  #image("images/testset2.svg", width: w)
][
  #image("images/testset3.svg",width: w)
]][
#grid(columns: 2)[
  #image("images/testset4.svg", width: w)
][
  #image("images/testset5.svg", width: w)
]]
]

== Wyniki testów wydajności i poprawności

#set table(align: center + horizon)
#show table: set par(justify: false)
#show table.cell.where(x: 0).or(table.cell.where(y:0)): strong

=== Zbiór 1

#grid(columns: (7fr, 9fr), align: horizon)[
#image("images/diag_uniform.png", width: 90%)][
#{
  show table.cell: set text(size: 9pt)
  let t1 = csv("tables/uniform.csv")
  table(inset: 6pt,
    columns: t1.at(0).len(),
    ..t1.flatten()
  )
}
]

#text(size: 15pt)[Dla zbioru w pełni losowego, bez przewidywalnej liczby punktów otoczki najszybsze okazjują się algorytmy górnej i dolnej otoczki, przyrostowy oraz Quickhull. Pozostałe algorytmy jednak znacząco od nich nie odbiegają z wykluczeniem algorytmu Chana. Może wydawać się, że algorytm Chana nie osiąga oczekiwanej złożoności, jednak rozbieżność może wynikać z charakterystyki algorytmu i dużej stałej nie branej pod uwagę podczas opisywania prędkości poprzez notację dużego O.]

=== Zbiór 2

#grid(columns: (7fr, 9fr), align: horizon)[
#image("images/diag_circle.png", width: 90%)][
#{
  show table.cell: set text(size: 9pt)
  let t1 = csv("tables/circle.csv")
  table(inset: 6pt,
    columns: t1.at(0).len(),
    ..t1.flatten()
  )
}
]

#text(size: 15pt)[Dla zbioru, w którym każdy punkt należy do otoczki można zaobserwować wyniki zgodne z oczekiwaniami. Czasy procesora algorymów Jarvisa oraz Chana, których złożoność obliczeniowa degraduje przy takich danych do kolejno $O(n^2)$ oraz $O(n log b)$ odbiegają znacząco od czasów pozostałych algorytmów. ]

=== Zbiór 3

#grid(columns: (7fr, 9fr), align: horizon)[
#image("images/diag_zigzag.png", width: 90%)][
#{
  show table.cell: set text(size: 9pt)
  let t1 = csv("tables/zigzag.csv")
  table(inset: 6pt,
    columns: t1.at(0).len(),
    ..t1.flatten()
  )
}
]

#text(size: 15pt)[Zbiór 3 jest bardzo podobny do zbioru 1, jedyne co go odróżnia to obramówka. Dzięki niej liczba punktów otoczki jest stała i wynosi 8. Zmiana ta daje się zauważyć poprzez mniejszy czas egzekucji algorytmów Jarvisa oraz Chana. Czasy egzekucji pozostałych programów są takie same, lub nieznacznie większe ze względu na dodatkowe punkty na obramówce.]

=== Zbiór 4

#grid(columns: (7fr, 9fr), align: horizon)[
#image("images/diag_square.png", width: 90%)][
#{
  show table.cell: set text(size: 9pt)
  let t1 = csv("tables/square.csv")
  table(inset: 6pt,
    columns: t1.at(0).len(),
    ..t1.flatten()
  )
}
]

#text(size: 15pt)[W zbiorze 4 liczba punktów otoczki ponownie wynosi 8, co ponownie pozwala na zaobserowowanie krótszego czasu egzekucji algorytmu Jarvisa oraz Chana. Ponadto każda podotoczka tworzona przez algorytm dziel i rządź ma dokładnie 4 punkty, co pozwala na szybkie ich łączenie i powoduje, że algorytm działa w przybliżeniu 2 razy szybciej niż w przypadku zbiorów 1 oraz 3. Podobnie algorytm górnej i dolnej otoczki dzięki dużej liczbie punktów współliniowych i małym rozmiarze pamiętanego stanu otoczki działa w przybliżeniu dwukrotnie szybciej.]

=== Zbiór 5

#grid(columns: (7fr, 9fr), align: horizon)[
#image("images/diag_x_square.png", width: 90%)][
#{
  show table.cell: set text(size: 9pt)
  let t1 = csv("tables/x_square.csv")
  table(inset: 6pt,
    columns: t1.at(0).len(),
    ..t1.flatten()
  )
}
]

#text(size: 15pt)[Tym razem liczba punktów otoczki zawsze wynosi 4, ze względu na obecność wierzchołków kwadratu w zbiorze 5. Algorytm Jarvisa wedle oczekiwań działa w przybliżeniu 2 razy szybciej. Czas działaniu algorytmu Chana również spadł znacząco, co w połączeniu z brakiem różnicy w liczbie punktów względem zbioru 4 potwierdza jego teoretyczną złożoność $O(n log k)$. Ponadto obecność przekątnych spowodowała, że algorytmy dziel i rządź oraz górnej i dolnej otoczki nie były już takie szybkie jak w zbiorze 4 i ich czasy pracy zbliżyły się do tych na zbiorze 1.]

= Podsumowanie

= Dodatek

== Analiza złożoności algorytmu Chana

#{
  codly(
  annotation-format: none,
  annotations: (
    (
      start: 6,
      end: 19,
      content: block(
        width: 13em,
        [$O(log m) times n / m times m = O(n log m)$]
      )
    ),
  ),
  highlights: (
    (line: 3, start: 5, end: none, fill: red, tag: [$O (m log m) times n / m = O(n log m)$]),
    (line: 10, start: 13, end: none, fill: red, tag: [$O( log m)$]),
  ),
  highlighted-lines: (7,8,(9,green.lighten(70%)),(10,green.lighten(70%)),(11,green.lighten(70%)),(12,green.lighten(70%)),(13,green.lighten(70%)),14,15,16,17,18),
  )
  set text(size: 14.0pt)
```Python
def chan_hull(points, m):
    n = len(points)
    hulls = list(map(graham, map(list, batched(points, n=m))))
    p1 = max(points, key=lambda p: (p[0], p[1])) #najbardziej na prawo
    last = p1
    L = [last]
    for j in range(m):
        best = points[0] if points[0] != last else points[1] 
        for i in range(len(hulls)):
            q = rtangent(hulls[i], last) 
            d = det(last,best,q)
            if d < -eps or (d < eps and dist(last,best) < dist(last,q)):
                best = q
        L.append(best)
        last = best
        if best == p1:
            L.pop()  # usuwamy powtorzony punkt startowy
            return L
    return None
```
}

#{
  codly(
  annotation-format: none,
  annotations: (
    (
      start: 5,
      end: 9,
      content: block(
        width: 5.67em,
        [$times O(log log h)$]
      )
    ),
  ),
  highlights: (
    (line: 6, start: 9, end: none, fill: red, tag: [$O(n log m) = O(n log 2^(2^t))$]),
  ),
  highlighted-lines: (5,6,7,8,9)
  )
  set text(size: 19.0pt)
```Python
def chan(points):
    t = 0
    n = len(points)
    while True:
        m = min(n, 2**(2**t))
        result = step_chan(points, m)
        if result != None:
            return result
        t += 1
```
}
$ sum_(t=0)^(log log h) O(n log 2^(2^t)) = O(n) sum_(t=0)^(log log h) O(2^t) <= O(n) dot O(2^(log log h + 1))\ = O(n) dot O(log h) = O(n log h) $