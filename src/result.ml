open Core.Std
open Async.Std
open Or_errors.Std

include Deferred.Result

let ok = is_ok
let error = is_error
let both x y = failwith("nyi")

