(* Hex Prefix *)

module List = Core.List

let __check number =
    if number != 0 then 2 else 0

let __even number =
    (number mod 2) == 0

let rec __sum = function
| [ ]                       -> [ ]
| (first :: second :: rest) -> ((16 * first) + second) :: __sum rest
| _                         -> failwith "Never reached case!"

let encode list flag =
    let length = List.length list in

    if __even length then
        (16 * __check flag) :: __sum list

    else
        match list with
        | [ ]             -> failwith "Never reached case!"
        | (first :: rest) ->
            (16 * (__check flag + 1)) + first :: __sum rest

(* END *)
