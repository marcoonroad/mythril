(* Recursive Length Prefix *)

module Char   = Core.Char
module String = Core.String
module List   = Core.List

type tree =
| Character of char
| Integer   of int
| List      of tree list
| String    of string

(* === Encoding * ========================================================== *)

let rec __encode_length number offset =
    if number < 56 then
        Char.to_string (char_of_int (number + offset))

    else
        let binary = __to_binary number in
        let length = String.length binary in
        let prefix = Char.to_string (char_of_int (length + offset + 55)) in
        prefix ^ binary

and __to_binary number =
    if number = 0 then
        ""

    else
        let result    = number  /  256 in
        let remainder = number mod 256 in
        __to_binary result ^ Char.to_string (char_of_int remainder)

and __encode_character byte =
    __encode_integer (int_of_char byte)

and __encode_integer number =
    if number == 0 then
        "\xc0"

    else if (0 <= number) && (number < 128) then
        Char.to_string (char_of_int number)

    else
        let binary = __to_binary number in
        let length = String.length binary in
        let prefix = __encode_length length 128 in
        prefix ^ binary

and __encode_list = function
    | [ ]  -> "\xc0"
    | list ->
        let bytes  = List.map ~f:encode list in
        let result = List.fold_left ~f:(^) ~init:"" bytes in
        let length = String.length result in
        let prefix = __encode_length length 192 in
        prefix ^ result

and __encode_string = function
    | ""   -> "\x80"
    | text ->
        let length = String.length text in

        if length == 1 then
            __encode_character (String.get text 0)

        else
            let prefix = __encode_length length 128 in
            prefix ^ text

and encode = function
    | Character byte   -> __encode_character byte
    | String    text   -> __encode_string    text
    | Integer   number -> __encode_integer   number
    | List      tree   -> __encode_list      tree

(* TODO

    RLP decoder.

*)

(* END *)
