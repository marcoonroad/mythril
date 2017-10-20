(**

    Merkle tree using MD5 hash.

    @author Marco Aurélio da Silva <marcoonroad at gmail dot com>

 *)

type hash = string

(**

    Our Merkle tree. Match-only data structure.

 *)
type tree = private
| Leaf   of string * hash
| Branch of tree * tree * hash

val md5 : string -> string

(**
    Leaf constructor preserving Merkle tree invariants.
*)
val leaf   : string -> tree


(**

    Branch constructor preserving Merkle tree invariants.

 *)
val branch : tree -> tree -> tree

val check  : tree -> bool

(* END *)
