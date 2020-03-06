let () =
  let api_key = "your_api_key" in
  match
    Lwt_main.run
      (Weather_lwt_unix.by_city_state ~city_name:"London" ~state:"uk" ~api_key
         ?lang:None ?units:None)
  with
  | Ok { weather; _ } -> print_endline weather.description
  | Error (`Msg e) -> print_endline ("error: " ^ e)
