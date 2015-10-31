open Core.Std
open Async.Std
open Or_errors.Std

include RESULT with type ('ok, 'err) t = ('ok, 'err) Deferred.Result.t
