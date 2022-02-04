type runOptions = {
  cmd: array<string>,
  stdout: string,
  stderr: string,
}

type processStatus = {success: bool, code: int}

type process
@send external status: process => Async.t<processStatus> = "status"
@send external output: process => Async.t<Js.TypedArray2.Uint8Array.t> = "output"
@send external stderrOutput: process => Async.t<Js.TypedArray2.Uint8Array.t> = "stderrOutput"

@val external _run: runOptions => process = "Deno.run"

let run = cmd => {
  `Running command: ${cmd->Array.join(" ")}`->Console.log
  let proc = _run({cmd: cmd, stdout: "piped", stderr: "piped"})
  let status = proc->status
  let output = proc->output
  let stderrOutput = proc->stderrOutput
  (status, output, stderrOutput)
  ->Async.seq3
  ->Async.map((({code}, output, stderrOutput)) => {
    let decoder = Decoder.new()
    let output = decoder->Decoder.decode(output)
    let errOutput = decoder->Decoder.decode(stderrOutput)
    code == 0 ? Ok(output) : Error(`${errOutput} (Exit code: ${code->Int.toString})`)
  })
}
