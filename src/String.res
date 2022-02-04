let includes = Js.String2.includes
let startsWith = Js.String2.startsWith
let endsWith = Js.String2.endsWith
let slice = Js.String2.slice
let sliceToEnd = Js.String2.sliceToEnd
let split = Js.String2.split
let trim = Js.String2.trim
let sub = (s, start, end) => s->Js.String2.slice(~from=start, ~to_=end)
let match = Js.String2.match_
let repeat = Js.String2.repeat