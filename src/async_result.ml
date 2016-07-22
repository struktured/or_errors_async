module Deferred = Async.Std.Deferred

module Impl =
struct
  module Monad_infix =
    struct
      include Deferred.Result.Monad_infix
      let (>|=) = (>>|)
    end
   let (>|=) = Monad_infix.(>>|)

   let str_format_to_string pref (ft:Format.formatter -> 'a -> unit) (x:'a) =
     Format.sprintf "%s=%s" pref (ft Format.str_formatter x; Format.flush_str_formatter())

   include (Deferred.Result :
     module type of Deferred.Result with module Monad_infix := Monad_infix)
   let both x y = bind x (fun x' -> map ~f:(fun y' -> (x', y')) y)
end


module Signature : Or_errors.Result.S =
struct
    include Impl
end

include Impl
