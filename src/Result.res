type t<'a, 'e> = Belt.Result.t<'a, 'e>

let toOption = r => switch r {
| Ok(v) => Some(v)
| Error(v) => None
}

let map = Belt.Result.map
let flatMap = Belt.Result.flatMap
let flatten = o =>
  switch o {
  | Ok(Ok(o)) => Ok(o)
  | Ok(Error(e)) => Error(e)
  | Error(e) => Error(e)
  }

let mapError = (r, f) =>
  switch r {
  | Error(val) => Error(val->f)
  | Ok(y) => Ok(y)
  }
let flatMapError = (r, f) => r->mapError(f)->flatten

let fold = (r, f) =>
  switch r {
  | Error(val) => Ok(val->f)
  | Ok(y) => Ok(y)
  }

let flatFold = (r, f) =>
  switch r {
  | Error(val) => val->f
  | Ok(y) => y
  }

let seq = (a: array<result<'a, 'error>>) => {
  a->Array.reduce((a, e) =>
    switch (a, e) {
    | (Ok(a), Ok(e)) => Ok(Array.concat(a, [e]))
    | (Error(e), _) => Error(e)
    | (_, Error(e)) => Error(e)
    }
  , Ok([]))
}

let seq2 = ((a1: result<'a, 'error>, a2: result<'b, 'error>)) => {
  switch (a1, a2) {
  | (Ok(a1), Ok(a2)) => Ok(a1, a2)
  | (Error(e), _) => Error(e)
  | (_, Error(e)) => Error(e)
  }
}

let seq3 = ((a1: result<'a, 'error>, a2: result<'b, 'error>, a3: result<'c, 'error>)) => {
  switch (a1, a2, a3) {
  | (Ok(a1), Ok(a2), Ok(a3)) => Ok(a1, a2, a3)
  | (Error(e), _, _) => Error(e)
  | (_, Error(e), _) => Error(e)
  | (_, _, Error(e)) => Error(e)
  }
}

let seq4 = ((
  a1: result<'a, 'error>,
  a2: result<'b, 'error>,
  a3: result<'c, 'error>,
  a4: result<'d, 'error>,
)) => {
  switch (a1, a2, a3, a4) {
  | (Ok(a1), Ok(a2), Ok(a3), Ok(a4)) => Ok(a1, a2, a3, a4)
  | (Error(e), _, _, _) => Error(e)
  | (_, Error(e), _, _) => Error(e)
  | (_, _, Error(e), _) => Error(e)
  | (_, _, _, Error(e)) => Error(e)
  }
}
