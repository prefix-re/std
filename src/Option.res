let toResult = (o, err) => switch o {
| Some(o) => Ok(o)
| None => Error(err)
}

let isSome = Belt.Option.isSome
let isNone = Belt.Option.isNone

let map = Belt.Option.map
let flatMap = Belt.Option.flatMap
let flatten = o => switch o {
| Some(Some(o)) => Some(o)
| _ => None
}

let seq = (a: array<option<'a>>) => {
  a->Array.reduce((a, e) =>
    switch (a, e) {
    | (Some(a), Some(e)) => Some(Array.concat(a, [e]))
    | (None, _) => None
    | (_, None) => None
    }
  , Some([]))
}

let seq2 = ((a1: option<'a>, a2: option<'b>)) => {
  switch (a1, a2) {
  | (Some(a1), Some(a2)) => Some(a1, a2)
  | (None, _) => None
  | (_, None) => None
  }
}

let seq3 = ((a1: option<'a>, a2: option<'b>, a3: option<'c>)) => {
  switch (a1, a2, a3) {
  | (Some(a1), Some(a2), Some(a3)) => Some(a1, a2, a3)
  | (None, _, _) => None
  | (_, None, _) => None
  | (_, _, None) => None
  }
}

let seq4 = ((a1: option<'a>, a2: option<'b>, a3: option<'c>, a4: option<'d>)) => {
  switch (a1, a2, a3, a4) {
  | (Some(a1), Some(a2), Some(a3), Some(a4)) => Some(a1, a2, a3, a4)
  | (None, _, _, _) => None
  | (_, None, _, _) => None
  | (_, _, None, _) => None
  | (_, _, _, None) => None
  }
}
