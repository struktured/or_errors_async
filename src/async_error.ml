open Core.Std
open Async.Std
open Or_errors.Std
include Core.Std.Error
let show = to_string_hum
let pp ft (t:t) = Format.fprintf ft "%s" (show t)
