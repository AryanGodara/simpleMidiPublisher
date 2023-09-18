let () =
  print_endline "Launching UDP Client...";
  (* let msgList = ["903C7F"; "803C00"; "903E7F"; "803E00";  "90407F"; "804000"; "90437F"; "804300"; "90457F";  "804500"] in *)
  let msgList = ["903C28" ; "903C00" ; "903C1e" ; "903C00" ; "90432D" ; "904300" ; "904332"; "904300"; "90452D" ; "904500"; "904532"; "904500"; "904323";  "904300";  "904132"; "904100"; "90412D"; "904100"; "904032"; "904000" ; "904028"; "904000" ; "903E2D"; "903E00"; "903E32" ; "903E00" ; "903C1E"; "903C00"] in

(* let rec extract_note_msgs msgs acc =
  match msgs with
  | [] -> List.rev acc
  | hd :: tl ->
    let status_byte = String.sub hd 0 2 in
    if status_byte = "90" || status_byte = "80" then
      extract_note_msgs tl (hd :: acc)
    else
      extract_note_msgs tl acc
    in

let midi_data = "4d54726b0000008c0000ff5804040230080000ff5902000000903c28810080903c008100909c28810080909c00810090432d8100904300800090452d81009045008000904532810090450080009043238200904300810090412d8100904100800090412d8100904100800090403264400904000081009040280080903e2d4000903e008000903e328000903e008000903c1e8200903c008000ff2f00"
  in
let msgList = extract_note_msgs (String.split_on_char ';' midi_data) [] *)
(* in *)
  (* 
  ff 58 04 04 02 30 08   
  *)
  (* The code has been updated to check a midi pitch bend message *)

  let () = Logs.set_reporter (Logs.format_reporter ()) in
  let () = Logs.set_level (Some Logs.Info) in

  let client_socket = Client.create_socket () in
  Lwt_main.run Client.(handle_request client_socket msgList)
