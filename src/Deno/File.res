@module("fs") external exists: string => bool = "existsSync"

@val external _read: string => string = "Deno.readTextFileSync"
let read = (path: string) => exists(path) ? Ok(_read(path)) : Error(`${path} does not exist`)

@val external _write: (string, Js.TypedArray2.Uint8Array.t) => unit = "Deno.writeFileSync"
let write = (data, path) => path->_write(data)
