type some<T> = {
 TAG: 0,
 _0: T
}

type none = {
 TAG: 1,
}

type option<T> = some<T> | none

const Some = <T>(_0: T): some<T> => ({ TAG: 0, _0 });
const None = ({ TAG: 1 });

const isSome = <T>(v: option<T>) => v.TAG === 0
const isNone = <T>(v: option<T>) => v.TAG === 1

const map = <T>(v: option<T>, f: option<T> => option<T>): option<T> => isSome(v) ? f(v) : v
