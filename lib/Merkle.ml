module Ck = Cryptokit

type hash = string

type tree =
| Leaf   of string * hash
| Branch of tree * tree * hash

(*

let md5 text =
    Digest.to_hex (Digest.string text)

*)

let md5 text =
    let md5algo = Ck.Hash.md5 ( ) in
    Ck.hash_string md5algo text

let leaf text =
    let hash = md5 text in
    Leaf (text, hash)

let hashOf = function
| Leaf (_, hash)      -> hash
| Branch (_, _, hash) -> hash

let branch left right =
    let leftHash  = hashOf left  in
    let rightHash = hashOf right in
    let hash      = md5 (leftHash ^ rightHash) in
    Branch (left, right, hash)

let check = function
| Leaf (text, hash)          -> md5 text = hash
| Branch (left, right, hash) -> md5 (hashOf left ^ hashOf right) = hash

(* TODO

    Encoding from Merkle to RLP and vice-versa.

 *)

(* END *)
