#import "@preview/touying:0.6.1": *
#import "@preview/cetz:0.4.2"
#import themes.university: *
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#slide(repeat: 19, self => [
#let (uncover, only) = utils.methods(self)
=== Przykład
#only(1)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), close: false, stroke: (paint: red, thickness: 4pt))
line((-1.704504, -3.628254), (5.474815, -1.551338), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(2)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), close: false, stroke: (paint: red, thickness: 4pt))
line((-1.704504, -3.628254), (4.013157, 3.900567), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(3)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), close: false, stroke: (paint: red, thickness: 4pt))
line((-1.704504, -3.628254), (0.616952, 3.727491), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(4)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), close: false, stroke: (paint: red, thickness: 4pt))
line((-1.704504, -3.628254), (-1.575534, 1.996727), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(5)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), close: false, stroke: (paint: red, thickness: 4pt))
line((-1.704504, -3.628254), (-1.747494, 0.309233), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(6)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), close: false, stroke: (paint: red, thickness: 4pt))
line((-1.704504, -3.628254), (-4.842769, 3.77076), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(7)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), close: false, stroke: (paint: red, thickness: 4pt))
line((-1.704504, -3.628254), (-4.32689, -1.205185), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(8)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (-1.704504, -3.628254), close: false, stroke: (paint: red, thickness: 4pt))
line((5.474815, -1.551338), (-1.704504, -3.628254), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(9)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), close: false, stroke: (paint: red, thickness: 4pt))
line((5.474815, -1.551338), (4.013157, 3.900567), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(10)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), close: false, stroke: (paint: red, thickness: 4pt))
line((5.474815, -1.551338), (0.616952, 3.727491), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(11)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), close: false, stroke: (paint: red, thickness: 4pt))
line((4.013157, 3.900567), (-1.575534, 1.996727), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(12)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), close: false, stroke: (paint: red, thickness: 4pt))
line((4.013157, 3.900567), (-4.32689, -1.205185), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(13)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-1.704504, -3.628254), close: false, stroke: (paint: red, thickness: 4pt))
line((-4.842769, 3.77076), (-1.704504, -3.628254), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(14)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-1.704504, -3.628254), close: false, stroke: (paint: red, thickness: 4pt))
line((-4.842769, 3.77076), (5.474815, -1.551338), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(15)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-4.32689, -1.205185), close: false, stroke: (paint: red, thickness: 4pt))
line((-4.842769, 3.77076), (-4.32689, -1.205185), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(16)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-4.32689, -1.205185), (-1.704504, -3.628254), close: false, stroke: (paint: red, thickness: 4pt))
line((-4.32689, -1.205185), (-1.704504, -3.628254), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(17)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-4.32689, -1.205185), (-1.704504, -3.628254), close: false, stroke: (paint: red, thickness: 4pt))
line((-4.32689, -1.205185), (5.474815, -1.551338), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(18)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-4.32689, -1.205185), (-1.704504, -3.628254), close: false, stroke: (paint: red, thickness: 4pt))
line((-4.32689, -1.205185), (-4.842769, 3.77076), stroke: (paint: blue, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        })]]
#only(19)[#align(center+horizon)[#cetz-canvas(length: 1.8em, {import cetz.draw: *
line((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-4.32689, -1.205185), close: true, stroke: (paint: red, thickness: 4pt))
for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (0.616952, 3.727491), (-1.575534, 1.996727), (-1.747494, 0.309233), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: gray, stroke: black)
        }
        for point in ((-1.704504, -3.628254), (5.474815, -1.551338), (4.013157, 3.900567), (-4.842769, 3.77076), (-4.32689, -1.205185)) {
            circle(point, radius: 0.21em, fill: red, stroke: black)
        }
        })]]
])
