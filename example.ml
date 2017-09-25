exception Error
exception Division_by_zero


let passing =
  QCheck.Test.make ~count:1000000
    ~name:"toy example"
    (QCheck.quad QCheck.small_signed_int QCheck.small_signed_int QCheck.small_signed_int QCheck.small_signed_int)
    (fun (a, b, c, d) ->
      let () = print_string ("(" ^ (string_of_int a) ^ ","  ^ (string_of_int b) ^ ","  ^ (string_of_int c) ^ "," ^ (string_of_int d) ^  ")")  in
      if ((a * b > 20 && b + c < 40) || (b * d < 20 && c + d < -10) || (a *b < -20 && d - c > 20) || (d* a < 30 && b + c > 50)) then
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
