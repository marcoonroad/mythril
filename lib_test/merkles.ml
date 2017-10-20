open Alcotest

module Merkle = Mythril.Merkle

let __leaf_case ( ) =
    let text = "Hello, World!" in
    let leaf = Merkle.leaf text in
    let hash = Merkle.md5 text in

    (match leaf with
    | Leaf (text', hash') ->
	(check string "matching leaf text" text text';
	check string "matching leaf hash" hash hash')
    | _ ->
	failwith "Invalid case: expected Leaf, got Branch!");
    
    ( )

let __branch_case ( ) =
    let leftText  = "Aliens are invading our dear World!" in
    let rightText = "Alt-coins are dominating our dear World!" in
    let leftHash  = Merkle.md5 leftText in
    let rightHash = Merkle.md5 rightText in
    let leftLeaf  = Merkle.leaf leftText in
    let rightLeaf = Merkle.leaf rightText in
    let branch    = Merkle.branch leftLeaf rightLeaf in
    let hash      = Merkle.md5 (leftHash ^ rightHash) in

    (match branch with
    | Branch (_left, _right, hash') ->
	check string "matching branch hash" hash hash'
    | _ ->
	failwith "Invalid case: expected Branch, got Leaf!");

    ( )

let suite = [
    "leaf",   `Quick, __leaf_case;
    "branch", `Quick, __branch_case
]

let ( ) = run "Merkle Tests" [
    "test suite", suite;
]

(* END *)
