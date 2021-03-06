type array_like<'a> = Js.Array2.array_like<'a>

@get_index external get: (array<'a>, int) => option<'a> = ""
@set_index external set: (array<'a>, int, 'a) => unit = ""

let concat = Js.Array2.concat
let length = Js.Array2.length
let empty = a => a->length == 0
let filter = Js.Array2.filter
let flat = Belt.Array.concatMany
let flatMap = (a, fn) => a->Js.Array2.map(fn)->flat
let mapWithIndex = Belt.Array.mapWithIndex
let flatMapWithIndex = (a, fn) => a->mapWithIndex(fn)->flat
let from = Js.Array2.from
let includes = Js.Array2.includes
let join = Js.Array2.joinWith
let map = Js.Array2.map
let reduce = Js.Array2.reduce
let slice = Belt.Array.slice
let sort = Js.Array2.sortInPlaceWith
let some = Js.Array2.some
let indexOf = Js.Array2.indexOf
let find = Js.Array2.find

let uniq = a => {
  a->reduce((a, i) => a->includes(i) ? a : a->concat([i]), [])
}

let groupBy = (a, fn) => a->reduce((m, v) =>
    m->Belt.Map.String.set(
      v->fn,
      switch m->Belt.Map.String.get(v->fn) {
      | Some(a) => a->concat([v])
      | None => [v]
      },
    )
  , Belt.Map.String.empty)->Belt.Map.String.toArray
