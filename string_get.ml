exception Error
exception Division_by_zero


let passing =
  QCheck.Test.make ~count:1000000
    ~name:"string get example"
    (QCheck.pair QCheck.printable_string QCheck.small_nat)
    (fun (a, b) ->
      let a = String.map (fun x -> if x = '\n' then ' ' else x) a in
      let () = print_string ("(" ^ (a) ^ ","  ^ (string_of_int b) ^  ")")  in
      if (0 <= b && b < String.length a) then
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
