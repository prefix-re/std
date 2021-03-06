// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as Array$Std from "./Array.js";
import * as Belt_Result from "rescript/lib/es6/belt_Result.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";

function toOption(r) {
  if (r.TAG === /* Ok */0) {
    return Caml_option.some(r._0);
  }
  
}

function flat(r) {
  if (r.TAG !== /* Ok */0) {
    return {
            TAG: /* Error */1,
            _0: r._0
          };
  }
  var v = r._0;
  if (v.TAG === /* Ok */0) {
    return {
            TAG: /* Ok */0,
            _0: v._0
          };
  } else {
    return {
            TAG: /* Error */1,
            _0: v._0
          };
  }
}

function mapError(r, f) {
  if (r.TAG === /* Ok */0) {
    return {
            TAG: /* Ok */0,
            _0: r._0
          };
  } else {
    return {
            TAG: /* Error */1,
            _0: Curry._1(f, r._0)
          };
  }
}

function flatMapError(r, f) {
  return flat(mapError(r, f));
}

function fold(r, f) {
  if (r.TAG === /* Ok */0) {
    return {
            TAG: /* Ok */0,
            _0: r._0
          };
  } else {
    return {
            TAG: /* Ok */0,
            _0: Curry._1(f, r._0)
          };
  }
}

function flatFold(r, f) {
  if (r.TAG === /* Ok */0) {
    return {
            TAG: /* Ok */0,
            _0: r._0
          };
  } else {
    return Curry._1(f, r._0);
  }
}

function seq(a) {
  return Array$Std.reduce(a, (function (a, e) {
                if (a.TAG === /* Ok */0) {
                  if (e.TAG === /* Ok */0) {
                    return {
                            TAG: /* Ok */0,
                            _0: Array$Std.concat(a._0, [e._0])
                          };
                  } else {
                    return {
                            TAG: /* Error */1,
                            _0: e._0
                          };
                  }
                } else {
                  return {
                          TAG: /* Error */1,
                          _0: a._0
                        };
                }
              }), {
              TAG: /* Ok */0,
              _0: []
            });
}

function seq2(param) {
  var r2 = param[1];
  var r1 = param[0];
  if (r1.TAG === /* Ok */0) {
    if (r2.TAG === /* Ok */0) {
      return {
              TAG: /* Ok */0,
              _0: [
                r1._0,
                r2._0
              ]
            };
    } else {
      return {
              TAG: /* Error */1,
              _0: r2._0
            };
    }
  } else {
    return {
            TAG: /* Error */1,
            _0: r1._0
          };
  }
}

function seq3(param) {
  var r3 = param[2];
  var r2 = param[1];
  var r1 = param[0];
  if (r1.TAG === /* Ok */0) {
    if (r2.TAG === /* Ok */0) {
      if (r3.TAG === /* Ok */0) {
        return {
                TAG: /* Ok */0,
                _0: [
                  r1._0,
                  r2._0,
                  r3._0
                ]
              };
      } else {
        return {
                TAG: /* Error */1,
                _0: r3._0
              };
      }
    } else {
      return {
              TAG: /* Error */1,
              _0: r2._0
            };
    }
  } else {
    return {
            TAG: /* Error */1,
            _0: r1._0
          };
  }
}

function seq4(param) {
  var r4 = param[3];
  var r3 = param[2];
  var r2 = param[1];
  var r1 = param[0];
  if (r1.TAG === /* Ok */0) {
    if (r2.TAG === /* Ok */0) {
      if (r3.TAG === /* Ok */0) {
        if (r4.TAG === /* Ok */0) {
          return {
                  TAG: /* Ok */0,
                  _0: [
                    r1._0,
                    r2._0,
                    r3._0,
                    r4._0
                  ]
                };
        } else {
          return {
                  TAG: /* Error */1,
                  _0: r4._0
                };
        }
      } else {
        return {
                TAG: /* Error */1,
                _0: r3._0
              };
      }
    } else {
      return {
              TAG: /* Error */1,
              _0: r2._0
            };
    }
  } else {
    return {
            TAG: /* Error */1,
            _0: r1._0
          };
  }
}

var isOk = Belt_Result.isOk;

var isError = Belt_Result.isError;

var map = Belt_Result.map;

var flatMap = Belt_Result.flatMap;

export {
  toOption ,
  isOk ,
  isError ,
  map ,
  flatMap ,
  flat ,
  mapError ,
  flatMapError ,
  fold ,
  flatFold ,
  seq ,
  seq2 ,
  seq3 ,
  seq4 ,
  
}
/* No side effect */
