exception Error
exception Division_by_zero

let passing =
  QCheck.Test.make ~count:1000
    ~name:"nth of List"
    (QCheck.pair (QCheck.list (QCheck.small_int)) (QCheck.small_int))
    (fun (a,b) ->
      let rec str_list list = match list with
        | [] -> ""
        | [x] -> (string_of_int x)
        | h::t -> (string_of_int h) ^ ";" ^ (str_list t)
      in
      try
        let _ = List.nth a b in
        let () = print_string ("([" ^ (str_list a) ^ "]" ^ ", " ^ (string_of_int b) ^ ")") in
        let () = print_string(", T\n") in
        true
      with Failure("nth") ->
       let () = print_string ("([" ^ (str_list a) ^ "]" ^ ", " ^ (string_of_int b) ^ ")") in
       let () = print_string(", F\n") in
     true
)

let () =
  Printexc.record_backtrace true;
  let open OUnit2 in
  run_test_tt_main
    ("tests" >:::
       List.map QCheck_runner.to_ounit2_test [passing])
