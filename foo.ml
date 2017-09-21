exception Error
exception Division_by_zero


let passing =
  QCheck.Test.make ~count:1000
    ~name:"toy example"
    (QCheck.triple QCheck.small_signed_int QCheck.small_signed_int QCheck.small_signed_int)
    (fun (a, b, c) ->
      let () = print_string ("(" ^ (string_of_int a) ^ ","  ^ (string_of_int b) ^ ","  ^ (string_of_int c) ^ ")")  in
      if (a > 20 || (b < 20 && c < -10) || (a < -20 && c > 20)) then
        let () = print_string(", T") in
        let () = print_string  ("\n") in
        true
      else
        let () = print_string(", F") in
        let () = print_string  ("\n") in
        true
);;



let () =
  Printexc.record_backtrace true;
  let open OUnit2 in
  run_test_tt_main
    ("tests" >:::
       List.map QCheck_runner.to_ounit2_test [passing])
