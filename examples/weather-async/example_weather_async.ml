let () =
  let api_key = "your_api_key" in
  Async_kernel.Deferred.upon
    (Weather_async.by_city_state ~city_name:"London" ~state:"uk" ~api_key
       ?lang:None ?units:None) (function
    | Ok { weather; _ } -> print_endline weather.description
    | Error (`Msg e) -> print_endline ("error: " ^ e))
