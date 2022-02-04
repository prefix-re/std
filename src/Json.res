type rec t =
  | String(string)
  | Number(float)
  | Object(Dict.t<t>)
  | Array(array<t>)
  | Bool(bool)
  | Null

@val external _internalClass: 'a => string = "Object.prototype.toString.call"
external _asBool: 'a => bool = "%identity"
external _asString: 'a => string = "%identity"
external _asFloat: 'a => float = "%identity"
external _asArray: 'a => array<'a> = "%identity"
external _asDict: 'a => Dict.t<'a> = "%identity"

let rec classify = (value: t) => {
  switch _internalClass(value) {
  | "[object Boolean]" => Bool(_asBool(value))
  | "[object Null]" | "[object Undefined]" => Null
  | "[object String]" => String(_asString(value))
  | "[object Number]" => Number(_asFloat(value))
  | "[object Array]" => Array(_asArray(value)->Array.map(elem => elem->classify))
  | _ => Object(_asDict(value)->Dict.map(((key, val)) => (key, val->classify)))
  }
}

module Object = {
  let get = (json: t, key) =>
    switch json {
    | Object(dict) =>
      switch dict->Dict.get(key) {
      | Some(val) => val
      | None => Null
      }
    | _ => Null
    }
}

module Array = {
  let get = (json: t) =>
    switch json {
    | Array(array) => array
    | _ => []
    }
}

module String = {
  let get = (json: t) =>
    switch json {
    | String(str) => str
    | _ => ""
    }
}

@val external _parse: string => 'a = "JSON.parse"
let parse = string => string->_parse->classify
