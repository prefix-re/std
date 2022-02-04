// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";

function flatten2(param) {
  var match = param[1];
  var match$1 = param[0];
  return [
          match$1[0],
          match$1[1],
          match[0],
          match[1]
        ];
}

function flatten3(param) {
  var match = param[2];
  var match$1 = param[1];
  var match$2 = param[0];
  return [
          match$2[0],
          match$2[1],
          match$2[2],
          match$1[0],
          match$1[1],
          match$1[2],
          match[0],
          match[1],
          match[2]
        ];
}

function flatten4(param) {
  var match = param[3];
  var match$1 = param[2];
  var match$2 = param[1];
  var match$3 = param[0];
  return [
          match$3[0],
          match$3[1],
          match$3[2],
          match$3[3],
          match$2[0],
          match$2[1],
          match$2[2],
          match$2[3],
          match$1[0],
          match$1[1],
          match$1[2],
          match$1[3],
          match[0],
          match[1],
          match[2],
          match[3]
        ];
}

function map2(param, fn) {
  return [
          Curry._1(fn, param[0]),
          Curry._1(fn, param[1])
        ];
}

function map3(param, fn) {
  return [
          Curry._1(fn, param[0]),
          Curry._1(fn, param[1]),
          Curry._1(fn, param[2])
        ];
}

function map4(param, fn) {
  return [
          Curry._1(fn, param[0]),
          Curry._1(fn, param[1]),
          Curry._1(fn, param[2]),
          Curry._1(fn, param[3])
        ];
}

function flatMap2(param, fn) {
  return flatten2(map2([
                  param[0],
                  param[1]
                ], fn));
}

function flatMap3(param, fn) {
  return flatten3(map3([
                  param[0],
                  param[1],
                  param[2]
                ], fn));
}

function flatMap4(param, fn) {
  return flatten4(map4([
                  param[0],
                  param[1],
                  param[2],
                  param[3]
                ], fn));
}

export {
  flatten2 ,
  flatten3 ,
  flatten4 ,
  map2 ,
  map3 ,
  map4 ,
  flatMap2 ,
  flatMap3 ,
  flatMap4 ,
  
}
/* No side effect */
