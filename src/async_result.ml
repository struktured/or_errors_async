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

module Impl_showable =
struct
  include Impl
  module Showable = Or_errors.Result.Showable.Make(Impl)
  module type SHOWABLE = module type of Showable with type ('a,'b) t := ('a,'b) t
  include (Showable : SHOWABLE)
end

module Signature : Or_errors.Result.SHOWABLE =
struct
    include Impl_showable
end

include Impl_showable
