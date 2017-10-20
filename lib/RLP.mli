(**

    Recursive Length Prefix encoding.

    @author Marco Aurélio da Silva <marcoonroad at gmail dot com>

 *)

(**

    The available data types used for the encoding algorithm.

 *)
type tree =
| Character of char
| Integer   of int
| List      of tree list
| String    of string

(**

    This function is pure and therefore, thread-safe.

 *)
val encode : tree -> string

(* END *)
