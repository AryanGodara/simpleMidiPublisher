open Lwt.Infix

(* Shared mutable counter *)
let listen_address = Unix.inet_addr_loopback
let port = 9000

let handle_message msg =
  print_endline ("Received message in handle_message: " ^ msg);
  match msg with "quit" -> "quit" | _ -> "Ready for next message"

let send_message server_socket msg =
  Unix.sleepf 0.2;
  print_endline ("Printing note " ^ msg);
  let publishMsg = "publish 1 " ^ msg in
  Lwt_unix.sendto server_socket (Bytes.of_string publishMsg) 0 (String.length publishMsg) [] (ADDR_INET (listen_address, port))
  >>= fun _ -> Lwt.return_unit

let send_messages server_socket messages =
  Lwt_list.iter_s (send_message server_socket) messages

let rec handle_request server_socket midiMessageList =
  server_socket >>= fun server_socket ->
  send_messages server_socket midiMessageList
  >>= fun _ ->
  handle_request (Lwt.return server_socket) midiMessageList

(* let rec handle_request server_socket midiMessageList =
  server_socket >>= fun server_socket ->
  let userMsg = read_line () in
  send_messages server_socket midiMessageList
  >>= fun _ ->
  print_endline "Request sent"; *)

let create_socket () : Lwt_unix.file_descr Lwt.t =
  print_endline "Creating socket";
  let open Lwt_unix in
  let sock = socket PF_INET SOCK_DGRAM 0 in
  Lwt.return sock
