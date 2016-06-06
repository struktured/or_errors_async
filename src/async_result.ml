module Deferred = Async.Std.Deferred

module Impl = struct
  module Monad_infix =
    struct
      include Deferred.Result.Monad_infix
      let (>|=) = (>>|)
    end
   let (>|=) = Monad_infix.(>>|)

   include (Deferred.Result : 
     module type of Deferred.Result with module Monad_infix := Monad_infix)
   let both x y = bind x (fun x' -> map ~f:(fun y' -> (x', y')) y)
end

module Signature : Or_errors.Std.RESULT =
struct
    include Impl
end

include Impl
