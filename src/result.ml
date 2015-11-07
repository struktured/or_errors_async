open Core.Std
open Async.Std

module Monad_infix =
struct
  include Deferred.Result.Monad_infix
  let (>|=) = (>>|)
end

include (Deferred.Result : 
  module type of Deferred.Result with module Monad_infix := Monad_infix)
let ok t = failwith("nyi")
(* try
    let or_error = Deferred.Or_error.of_exn_result t in 
    Some (Deferred.Or_error.ok_exn or_error)
  with _ -> None *)
let error t = failwith("nyi")
let map f x = map x ~f
let bind f x = bind x f
let both x y = bind (fun x' -> map (fun y' -> (x', y')) y) x

