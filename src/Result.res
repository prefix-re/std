type t<'a, 'e> = Belt.Result.t<'a, 'e>

let toOption = r => switch r {
| Ok(v) => Some(v)
| Error(_) => None
}

let isOk = Belt.Result.isOk
let isError = Belt.Result.isError

let map = Belt.Result.map
let flatMap = Belt.Result.flatMap
let flat = r =>
  switch r {
  | Ok(Ok(v)) => Ok(v)
  | Ok(Error(e)) => Error(e)
  | Error(e) => Error(e)
  }

let mapError = (r, f) =>
  switch r {
  | Error(e) => Error(e->f)
  | Ok(v) => Ok(v)
  }
let flatMapError = (r, f) => r->mapError(f)->flat

let fold = (r, f) =>
  switch r {
  | Error(e) => Ok(e->f)
  | Ok(v) => Ok(v)
  }
let flatFold = (r, f) =>
  switch r {
  | Error(e) => e->f
  | Ok(v) => v
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

let seq2 = ((r1: result<'a, 'error>, r2: result<'b, 'error>)) => {
  switch (r1, r2) {
  | (Ok(v1), Ok(v2)) => Ok(v1, v2)
  | (Error(e), _) => Error(e)
  | (_, Error(e)) => Error(e)
  }
}

let seq3 = ((r1: result<'a, 'error>, r2: result<'b, 'error>, r3: result<'c, 'error>)) => {
  switch (r1, r2, r3) {
  | (Ok(v1), Ok(v2), Ok(v3)) => Ok(v1, v2, v3)
  | (Error(e), _, _) => Error(e)
  | (_, Error(e), _) => Error(e)
  | (_, _, Error(e)) => Error(e)
  }
}

let seq4 = ((
  r1: result<'a, 'error>,
  r2: result<'b, 'error>,
  r3: result<'c, 'error>,
  r4: result<'d, 'error>,
)) => {
  switch (r1, r2, r3, r4) {
  | (Ok(v1), Ok(v2), Ok(v3), Ok(v4)) => Ok(v1, v2, v3, v4)
  | (Error(e), _, _, _) => Error(e)
  | (_, Error(e), _, _) => Error(e)
  | (_, _, Error(e), _) => Error(e)
  | (_, _, _, Error(e)) => Error(e)
  }
}
