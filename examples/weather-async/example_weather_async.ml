open Async

let () =
  let api_key = "your_api_key" in
  let logger =
    let output = [ Log.Output.stdout () ] in
    Log.create ~level:`Info ~output ~on_error:`Raise
  in
  Command.async_spec ~summary:"Sample client" Command.Spec.empty (fun () ->
      Weather_async.by_city_state ~city_name:"London" ~state:"uk" ~api_key
        ?lang:None ?units:None
      >>= function
      | Ok { weather; _ } ->
          Log.info logger "%s" weather.description;
          Deferred.unit
      | Error (`Msg e) ->
          Log.error logger "error: %s" e;
          Deferred.unit)
  |> Command.run
