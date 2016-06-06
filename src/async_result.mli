open Core.Std
open Async.Std
open Or_errors.Std

type ('a, 'b) t = ('a, 'b) Deferred.Result.t

module Monad_infix : 
sig
    val (>>|) : ('a, 'd) t -> ('a -> 'b) -> ('b, 'd) t
    val (>|=) : ('a, 'd) t -> ('a -> 'b) ->  ('b, 'd) t
    val (>>=) : ('a, 'd) t -> ('a -> ('b, 'd) t) -> ('b, 'd) t
end

include module type of Deferred.Result with 
  type ('a, 'b) t := ('a, 'b) t and module Monad_infix := Monad_infix
(*  val (>>=) : ('a, 'd) t -> ('a -> ('b, 'd) t) -> ('b, 'd) t
  val (>|=) : ('a, 'd) t -> ('a -> 'b) ->  ('b, 'd) t
  val (>>|) : ('a, 'd) t -> ('a -> 'b) -> ('b, 'd) t*)

 
include RESULT with type ('a,'b) t := ('a,'b) t and 
 module Monad_infix := Monad_infix
