let () =
  print_endline "Launching UDP Client...";
  let msgList = ["903C7F"; "803C00"; "903E7F"; "803E00";  "90407F"; "804000"; "90437F"; "804300"; "90457F";  "804500"] in
  (* The code has been updated to check a midi pitch bend message *)

  let () = Logs.set_reporter (Logs.format_reporter ()) in
  let () = Logs.set_level (Some Logs.Info) in

  let client_socket = Client.create_socket () in
  Lwt_main.run Client.(handle_request client_socket msgList)
