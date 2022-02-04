@val @return(nullable) external get: string => option<string> = "Deno.env.get"

let getError = env => switch env->get {
| Some(val) => Ok(val)
| None => Error(`${env} not defined`)
} 