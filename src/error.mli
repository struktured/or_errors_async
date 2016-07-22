open Core.Std
open Async.Std
open Or_errors.Std

include module type of Core.Std.Error
val show : t -> string
val pp : Format.formatter -> t -> unit
