open Or_errors.Std
module Impl =
struct
  module Result = Async_result
  module Async_deferred = Async.Std.Deferred
  let (>|=) = Result.(>|=)

  module Monad_infix =
  struct
    include Async_deferred.Or_error.Monad_infix
    let (>|=) = (>|=)
  end

  include (Async_deferred.Or_error : module type of Async_deferred.Or_error with 
    module Monad_infix := Monad_infix)

  module Error = Error
  let of_result t = t
  let both (x:'a t) (y : 'b t) : ('a * 'b) t = Result.both x y
end

(* Ensure the implementation matches the OR_ERROR contract *)
module Signature : Or_errors.Std.OR_ERROR =
struct
    include Impl
end

include Impl
