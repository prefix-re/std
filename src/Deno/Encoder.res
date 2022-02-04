type t

@new external new: unit => t = "TextEncoder"
@send external encode: (t, string) => Js.TypedArray2.Uint8Array.t = "encode"
