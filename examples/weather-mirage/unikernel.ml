open Weather_lib.Response

let start _ =
  let api_key = "your_api_key" in
  ( match
      Lwt_main.run
        (Weather_mirage.by_city_state ~city_name:"London" ~state:"uk" ~api_key
           ?lang:None ?units:None)
    with
  | Ok { weather; _ } -> Logs.info (fun f -> f "%s" weather.description)
  | Error (`Msg e) -> Logs.info (fun f -> f "error: %s" e) );
  Lwt.return_unit
