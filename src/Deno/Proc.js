// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Int$Std from "../Int.js";
import * as Array$Std from "../Array.js";
import * as Async$Std from "../Async.js";
import * as Console$Std from "../Console.js";

function run(cmd) {
  Console$Std.log("Running command: " + Array$Std.join(cmd, " "));
  var proc = Deno.run({
        cmd: cmd,
        stdout: "piped",
        stderr: "piped"
      });
  var status = proc.status();
  var output = proc.output();
  var stderrOutput = proc.stderrOutput();
  return Async$Std.map(Promise.all([
                  status,
                  output,
                  stderrOutput
                ]), (function (param) {
                var code = param[0].code;
                var decoder = new TextDecoder();
                var output = decoder.decode(param[1]);
                var errOutput = decoder.decode(param[2]);
                if (code === 0) {
                  return {
                          TAG: /* Ok */0,
                          _0: output
                        };
                } else {
                  return {
                          TAG: /* Error */1,
                          _0: errOutput + " (Exit code: " + Int$Std.toString(code) + ")"
                        };
                }
              }));
}

export {
  run ,
  
}
/* No side effect */
