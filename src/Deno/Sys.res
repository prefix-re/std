@val external cpus: int = "navigator.hardwareConcurrency"
@val external _exit: int => unit = "Deno.exit"
let exit = code => {
  %debugger
  _exit(code)
}
