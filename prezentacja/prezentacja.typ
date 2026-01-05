#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

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

== Simple Animation

We can use `#pause` to #pause display something later.

#pause

Just like this.

#meanwhile

Meanwhile, #pause we can also use `#meanwhile` to #pause display other content synchronously.

#speaker-note[
  + This is a speaker note.
  + You won't see it unless you use `config-common(show-notes-on-second-screen: right)`
]


== Complex Animation

At subslide #touying-fn-wrapper((self: none) => str(self.subslide)), we can

use #uncover("2-")[`#uncover` function] for reserving space,

use #only("2-")[`#only` function] for not reserving space,

#alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.


== Callback Style Animation

#slide(
  repeat: 3,
  self => [
    #let (uncover, only, alternatives) = utils.methods(self)

    At subslide #self.subslide, we can

    use #uncover("2-")[`#uncover` function] for reserving space,

    use #only("2-")[`#only` function] for not reserving space,

    #alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.
  ],
)


== Math Equation Animation

Equation with `pause`:

$
  f(x) &= pause x^2 + 2x + 1 \
  &= pause (x + 1)^2 \
$

#meanwhile

Here, #pause we have the expression of $f(x)$.

#pause

By factorizing, we can obtain this result.


== CeTZ Animation

CeTZ Animation in Touying:

#cetz-canvas({
  import cetz.draw: *

  rect((0, 0), (5, 5))

  (pause,)

  rect((0, 0), (1, 1))
  rect((1, 1), (2, 2))
  rect((2, 2), (3, 3))

  (pause,)

  line((0, 0), (2.5, 2.5), name: "line")
})


== Fletcher Animation

Fletcher Animation in Touying:

#fletcher-diagram(
  node-stroke: .1em,
  node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),
  spacing: 4em,
  edge((-1, 0), "r", "-|>", `open(path)`, label-pos: 0, label-side: center),
  node((0, 0), `reading`, radius: 2em),
  edge((0, 0), (0, 0), `read()`, "--|>", bend: 130deg),
  pause,
  edge(`read()`, "-|>"),
  node((1, 0), `eof`, radius: 2em),
  pause,
  edge(`close()`, "-|>"),
  node((2, 0), `closed`, radius: 2em, extrude: (-2.5, 0)),
  edge((0, 0), (2, 0), `close()`, "-|>", bend: -40deg),
)


= Theorems

== Prime numbers

#definition[
  A natural number is called a #highlight[_prime number_] if it is greater
  than 1 and cannot be written as the product of two smaller natural numbers.
]
#example[
  The numbers $2$, $3$, and $17$ are prime.
  @cor_largest_prime shows that this list is not exhaustive!
]

#theorem(title: "Euclid")[
  There are infinitely many primes.
]
#pagebreak(weak: true)
#proof[
  Suppose to the contrary that $p_1, p_2, dots, p_n$ is a finite enumeration
  of all primes. Set $P = p_1 p_2 dots p_n$. Since $P + 1$ is not in our list,
  it cannot be prime. Thus, some prime factor $p_j$ divides $P + 1$. Since
  $p_j$ also divides $P$, it must divide the difference $(P + 1) - P = 1$, a
  contradiction.
]

#corollary[
  There is no largest prime number.
] <cor_largest_prime>
#corollary[
  There are infinitely many composite numbers.
]

#theorem[
  There are arbitrarily long stretches of composite numbers.
]

#proof[
  For any $n > 2$, consider $
    n! + 2, quad n! + 3, quad ..., quad n! + n
  $
]


= Others

== Side-by-side

#slide(composer: (1fr, 1fr))[
  First column.
][
  Second column.
]


== Multiple Pages

#lorem(200)


#show: appendix

= Appendix

== Appendix

Please pay attention to the current slide number.