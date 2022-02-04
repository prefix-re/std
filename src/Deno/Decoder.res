type t

@new external new: unit => t = "TextDecoder"
@send external decode: (t, Js.TypedArray2.Uint8Array.t) => string = "decode"
