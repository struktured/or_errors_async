module Deferred = Async.Std.Deferred

module Impl = struct
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
   let show a_f b_f t = map ~f:(str_format_to_string "Ok" a_f) t |> map_error ~f:(str_format_to_string "Error" b_f)
   let pp a_f b_f ft t = show a_f b_f t |>
                         map ~f:(Format.fprintf ft "%s") |>
                         map_error ~f:(Format.fprintf ft "%s")
end

module Signature : Or_errors.Std.RESULT =
struct
    include Impl
end

include Impl
