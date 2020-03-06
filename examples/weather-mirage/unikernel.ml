open Weather_lib.Response

let start _ =
  let api_key = "your_api_key" in
  ( match
      Lwt_main.run
        (Weather_mirage.by_city_state ~city_name:"London" ~state:"uk" ~api_key
           ?lang:None ?units:None)
    with
  | Ok { weather; _ } -> print_endline weather.description
  | Error (`Msg e) -> print_endline ("error: " ^ e) );
  Lwt.return_unit
