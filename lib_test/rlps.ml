open Alcotest
open Mythril.RLP

let __integer_case ( ) =
    check string "zero integer" (encode (Integer 0))    "\xc0";
    check string "byte integer" (encode (Integer 15))   "\x0f";
    check string "128 integer"  (encode (Integer 128))  "\129\128";
    check string "256 integer"  (encode (Integer 256))  "\130\001\000";
    check string "huge integer" (encode (Integer 1024)) "\x82\x04\x00";

    ( )

let __character_case ( ) =
    check string "null character"   (encode (Character '\x00')) "\xc0";
    check string "simple character" (encode (Character 'c'))    "\099";

    ( )

let __string_case ( ) =
    check string "one char string" (encode (String "d"))   "\100";
    check string "empty string"    (encode (String ""))    "\x80";
    check string "filled string"   (encode (String "dog")) "\x83dog";
    check string "cute string"     (encode (String "cat")) "\x83cat";

    check string "huge string"
        (encode (String "Lorem ipsum dolor sit amet, consectetur adipisicing elit"))
        ("\184\x38\076\111\114\101\109\032\105\112\115\117\109\032\100\111\108\111" ^
         "\114\032\115\105\116\032\097\109\101\116\044\032\099\111\110\115\101\099" ^
         "\116\101\116\117\114\032\097\100\105\112\105\115\105\099\105\110\103\032" ^
         "\101\108\105\116");

    ( )

let __list_case ( ) =
    check string "empty list"
        (encode (List [ ]))
        "\xc0";

    check string "filled list"
        (encode (List [ String "dog"; String "cat" ]))
        "\200\131\100\111\103\131\099\097\116";

    check string "also filled list"
        (encode (List [ String "c"; String "cat"; String "dog"]))
        "\201\099\131\099\097\116\131\100\111\103";

    check string "huge list"
        (encode (List [
            String "dog";
            Integer 15;
            List [ String "cat"; String "cat"; List [ ] ];
            Integer 1024;
            String "tachikoma"
        ]))
        ("\220\131\100\111\103\015\201\131\099\097\116\131\099\097\116" ^
         "\192\130\004\000\137\116\097\099\104\105\107\111\109\097");

    check string "set three"
        (encode (List [
            List [ ];
            List [ List [ ] ];
            List [ List [ ]; List [ List [ ] ] ]
        ])) "\xc7\xc0\xc1\xc0\xc3\xc0\xc1\xc0";

    check string "yet another"
        (encode (List [ String "zw"; List [ Integer 4 ]; Integer 1 ]))
        "\xc6\x82\x7a\x77\xc1\x04\x01";

    ( )

let suite = [
    "integer",   `Quick, __integer_case;
    "string",    `Quick, __string_case;
    "list",      `Quick, __list_case;
    "character", `Quick, __character_case
]

let ( ) = run "RLP Tests" [
    "test suite", suite;
]

(* END *)
