type t<'a, 'error> = Async.t<Result.t<'a, 'error>>

let to = t => t->Ok->Async.to
let toError = t => t->Error->Async.to
let fromResult = t => t->Async.to

let flat = (to: t<t<'a, 'error>, 'error>) => {
  to->Async.flatMap(r => {
    switch r {
    | Ok(ti) => ti
    | Error(error) => Error(error)->Async.to
    }
  })
}

let map = (a, fn) => a->Async.map(res => res->Result.map(fn))
let flatMap = (a, fn) => a->Async.map(res => res->Result.map(fn))->flat
let mapError = (a, fn) => a->Async.map(res => res->Result.mapError(fn))
let flatMapError = (a, fn) => a->Async.map(res => res->Result.mapError(fn))->flat
let fold = (a, fn) => a->Async.map(res => res->Result.fold(fn))
let flatFold = (a, fn) => a->Async.map(res => res->Result.fold(fn))->flat

let seq = (a: array<t<'a, 'error>>) => a->Async.seq->Async.map(Result.seq)

let seq2 = ((a1: t<'a, 'error>, a2: t<'b, 'error>)) => (a1, a2)->Async.seq2->Async.map(Result.seq2)

let seq3 = ((a1: t<'a, 'error>, a2: t<'b, 'error>, a3: t<'c, 'error>)) =>
  (a1, a2, a3)->Async.seq3->Async.map(Result.seq3)

let seq4 = ((a1: t<'a, 'error>, a2: t<'b, 'error>, a3: t<'c, 'error>, a4: t<'d, 'error>)) =>
  (a1, a2, a3, a4)->Async.seq4->Async.map(Result.seq4)

let rec pool = (tasks: array<unit => Async.t<result<'a, string>>>, count): Async.t<
  result<array<'a>, string>,
> => {
  let curTasks =
    tasks
    ->Array.slice(~offset=0, ~len=count)
    ->Array.map(f => (resolve => resolve(f()))->Async.new)
    ->Async.seq
  let rest = tasks->Array.slice(~offset=count, ~len=tasks->Array.length - count)
  `pool: ${rest->Array.length->Int.toString}`->Console.log
  curTasks
  ->Async.flatMap(res1 => {
    let tasks = res1->seq
    tasks->map(res1 =>
      switch rest->Array.length {
      | 0 => res1->to
      | _ => rest->pool(count)->map(res2 => [res1, res2]->Array.flat)
      }
    )
  })
  ->flat
}
