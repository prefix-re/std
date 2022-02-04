type t<'a> = Js.Dict.t<'a>

let empty = Js.Dict.empty
let toArray = Js.Dict.entries
let fromArray = Js.Dict.fromArray
let to = (key, val) => fromArray([(key, val)])
let get = Js.Dict.get
let concat = (d1, d2) => d1->toArray->Array.concat(d2->toArray)->fromArray

let map = (d, fn) => d->toArray->Array.map(fn)->fromArray
let flatten = d => d->Array.flatMap(toArray)->fromArray
let flatMap = (d, fn) => d->Array.flatMap(toArray)->Array.map(fn)->fromArray
