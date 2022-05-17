type ok<T> = {
 TAG: 0,
 _0: T
}

type err<E> = {
 TAG: 1,
 _0: E
}

type result<T, E> = ok<T> | err<E>

const Ok = <T>(_0: T): ok<T> => ({ TAG: 0, _0 });
const Err = <E>(_0: E): err<E> => ({ TAG: 1, _0 });

const isOk = <T, E>(v: result<T, E>) => v.TAG === 0
const isErr = <T, E>(v: result<T, E>) => v.TAG === 1

const map = <T, E>(v: result<T, E>, f: result<T, E> => result<T, E>): result<T, E> => isOk(v) ? f(v) : v