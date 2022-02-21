type t<+'a> = Js.Promise.t<'a>

type promiseFn<'a, +'b> = 'a => Js.Promise.t<'b>

@scope("Promise") @val external seq: array<t<'a>> => t<array<'a>> = "all"
@scope("Promise") @val external seq2: ((t<'a>, t<'b>)) => t<('a, 'b)> = "all"
@scope("Promise") @val external seq3: ((t<'a>, t<'b>, t<'c>)) => t<('a, 'b, 'c)> = "all"
@scope("Promise") @val external seq4: ((t<'a>, t<'b>, t<'c>, t<'d>)) => t<('a, 'b, 'c, 'd)> = "all"

type error = Js.Promise.error
let to = Js.Promise.resolve
let reject = Js.Promise.reject

@send external toString: 'a => string = "toString"
@send external mapErrorUnit: (t<'a>, error => unit) => t<'a> = "catch"
let mapError = (a, fn) => Js.Promise.catch(fn, a)
let flatMapError = (a, fn) => a->mapError(e => e->fn->to)
let exitError = a =>
  a->mapErrorUnit(e => {
    `Error: ${e->toString}`->Console.log
    exit(1)
  })

let map = (a, fn) => Js.Promise.then_(v => v->fn->to, a)
let flatMap = (a, fn) => Js.Promise.then_(fn, a)

@new external new: (('a => unit) => unit) => t<'a> = "Promise"
@new external newReject: (('a => unit, 'a => unit) => unit) => t<'a> = "Promise"

let sleep = (a, ms) =>
  a->flatMap(res => (resolve => Js.Global.setTimeout(_ => resolve(res), ms)->ignore)->new)

let rec pool = (tasks, count) => {
  let curTasks =
    tasks->Array.slice(~offset=0, ~len=count)->Array.map(f => (resolve => resolve(f()))->new)->seq
  let rest = tasks->Array.slice(~offset=count, ~len=tasks->Array.length - count)
  `pool: ${rest->Array.length->Int.toString}`->Console.log
  switch rest->Array.length {
  | 0 => curTasks
  | _ => curTasks->flatMap(res1 => rest->pool(count)->map(res2 => [res1, res2]->Array.flat))
  }
}
