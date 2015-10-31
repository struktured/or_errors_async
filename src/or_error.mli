open Or_errors.Std

(*module type S =
sig
  module Error : Error.S
  module Result : Result.S
  include Monad.S with type 'a t = ('a, Error.t) Result.t
  val of_result : ('a, Error.t) Result.t -> 'a t
end
*)

include OR_ERROR with 
  module Result = Result and
  module Error = Core.Std.Error and
  type 'a t := 'a Async.Std.Deferred.Or_error.t
