let flatten2 = (((e1, e2), (e3, e4))) => (e1, e2, e3, e4)
let flatten3 = (((e1, e2, e3), (e4, e5, e6), (e7, e8, e9))) => (e1, e2, e3, e4, e5, e6, e7, e8, e9)
let flatten4 = ((
  (e1, e2, e3, e4),
  (e5, e6, e7, e8),
  (e9, e10, e11, e12),
  (e13, e14, e15, e16),
)) => (e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16)

let map2 = ((e1, e2), fn) => (e1->fn, e2->fn)
let map3 = ((e1, e2, e3), fn) => (e1->fn, e2->fn, e3->fn)
let map4 = ((e1, e2, e3, e4), fn) => (e1->fn, e2->fn, e3->fn, e4->fn)

let flatMap2 = ((e1, e2), fn) => (e1, e2)->map2(fn)->flatten2
let flatMap3 = ((e1, e2, e3), fn) => (e1, e2, e3)->map3(fn)->flatten3
let flatMap4 = ((e1, e2, e3, e4), fn) => (e1, e2, e3, e4)->map4(fn)->flatten4
