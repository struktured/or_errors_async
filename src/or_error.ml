open Or_errors.Std

module Impl = struct
module Deferred = Async.Std.Deferred
let (>|=) = Result.(>|=)
module Monad_infix = struct
  include Deferred.Or_error.Monad_infix
  let (>|=) = (>|=)
end

include (Deferred.Or_error : module type of Deferred.Or_error with 
  module Monad_infix := Monad_infix)
module Result = Result
module Error = Error
let of_result = Deferred.Or_error.of_exn_result
let both (x:'a t) (y : 'b t) : ('a * 'b) t = Result.both x y
end

module Signature : Or_errors.Std.OR_ERROR =
struct
    include Impl
end

