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

let rec classify = value => {
  switch _internalClass(value) {
  | "[object Boolean]" => Bool(_asBool(value))
  | "[object Null]" | "[object Undefined]" => Null
  | "[object String]" => String(_asString(value))
  | "[object Number]" => Number(_asFloat(value))
  | "[object Array]" => Array(_asArray(value)->Array.map(elem => elem->classify))
  | _ => Object(_asDict(value)->Dict.map(((key, val)) => (key, val->classify)))
  }
}

let get = (yaml: t, key) =>
  switch yaml {
  | Object(dict) =>
    switch dict->Dict.get(key) {
    | Some(val) => val
    | None => Null
    }
  | _ => Null
  }

let map = (yml, f) =>
  switch yml {
  | Array(array) => array->Array.map(f)
  | _ => []
  }

@module("yaml") external _parse: string => t = "parse"
let parse = string => string->_parse->classify

let rec _stringify = (yml, level) =>
  switch yml {
  | String(string) => `"${string}"`
  | Number(float) => float->Float.toString
  | Object(obj) => {
      let entries = obj->Dict.toArray
      (level == 0 ? "" : "\n") ++
      entries
      ->Array.mapWithIndex((i, (key, val)) =>
        switch val {
        | Null => ""
        | Array([]) => ""
        | _ =>
          `${"  "->String.repeat(level)}${key}: ${val->_stringify(level + 1)}${i + 1 ==
              entries->Array.length
              ? ""
              : "\n"}`
        }
      )
      ->Array.join("")
    }
  | Array(array) =>
    (level == 0 ? "" : "\n") ++
    array
    ->Array.mapWithIndex((i, val) =>
      switch val {
      | Null => ""
      | _ =>
        `${"  "->String.repeat(level)}- ${val->_stringify(level + 1)}${i + 1 == array->Array.length
            ? ""
            : "\n"}`
      }
    )
    ->Array.join("")
  | Bool(bool) => bool ? "true" : "false"
  | Null => ""
  }

let stringify = yml => _stringify(yml, 0)
