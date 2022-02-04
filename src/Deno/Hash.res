@module("hash") external hash: 'a => string = "default"

let hashN = (data, n) => data->hash->String.slice(~from=0, ~to_=n)
