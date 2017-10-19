exception Error
exception Division_by_zero


(* y = x ^2 + 3x + 7*)
let passing =
  QCheck.Test.make ~count:10000000
    ~name:"string get example"
    (QCheck.pair QCheck.small_nat QCheck.small_nat)
    (fun (a, b) ->
      let () = print_string ("(" ^  (string_of_int a) ^ "," ^ (string_of_int b) ^  ")")  in
      if (b = a * a + 3 * a + 7) then
        let () = print_string(", F") in
        let () = print_string  ("\n") in
        true
      else
        let () = print_string(", T") in
        let () = print_string  ("\n") in
        true
);;



let () =
  Printexc.record_backtrace true;
  let open OUnit2 in
  run_test_tt_main
    ("tests" >:::
       List.map QCheck_runner.to_ounit2_test [passing])
