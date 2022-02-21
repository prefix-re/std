let toResult = (o, e) => switch o {
| Some(v) => Ok(v)
| None => Error(e)
}

let isSome = Belt.Option.isSome
let isNone = Belt.Option.isNone

let map = Belt.Option.map
let flatMap = Belt.Option.flatMap
let flat = o => switch o {
| Some(Some(v)) => Some(v)
| _ => None
}

let fold = (o, f) =>
  switch o {
  | None => Some(f())
  | Some(v) => Some(v)
  }
let flatFold = (r, f) =>
  switch r {
  | None => f()
  | Some(v) => v
  }

let seq = (a: array<option<'a>>) => {
  a->Array.reduce((a, o) =>
    switch (a, o) {
    | (Some(a), Some(v)) => Some(Array.concat(a, [v]))
    | (None, _) => None
    | (_, None) => None
    }
  , Some([]))
}

let seq2 = ((o1: option<'a>, o2: option<'b>)) => {
  switch (o1, o2) {
  | (Some(v1), Some(v2)) => Some(v1, v2)
  | (None, _) => None
  | (_, None) => None
  }
}

let seq3 = ((o1: option<'a>, o2: option<'b>, o3: option<'c>)) => {
  switch (o1, o2, o3) {
  | (Some(v1), Some(v2), Some(v3)) => Some(v1, v2, v3)
  | (None, _, _) => None
  | (_, None, _) => None
  | (_, _, None) => None
  }
}

let seq4 = ((o1: option<'a>, o2: option<'b>, o3: option<'c>, o4: option<'d>)) => {
  switch (o1, o2, o3, o4) {
  | (Some(v1), Some(v2), Some(v3), Some(v4)) => Some(v1, v2, v3, v4)
  | (None, _, _, _) => None
  | (_, None, _, _) => None
  | (_, _, None, _) => None
  | (_, _, _, None) => None
  }
}
