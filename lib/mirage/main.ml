module Main (Ch : Mirage_channel.S) = struct
  module IO = Cohttp_mirage.IO (Ch)
  module Client = Cohttp_mirage.Client

  let by_city_state_country ?userinfo ?host ?port ?fragment ?lang ?units
      ~city_name ~state ~country_code ~api_key =
    let open IO in
    let uri =
      Weather_lib.Query.by_city_state_country ?userinfo ?host ?port ?fragment
        ?lang ?units ~city_name ~state ~country_code ~api_key ()
    in
    Client.get uri >>= fun (_, body) ->
    Cohttp_lwt.Body.to_string body >>= fun body ->
    match Yojson.Basic.from_string body with
    | exception Yojson.Json_error msg -> IO.return (Rresult.R.error_msg msg)
    | json -> IO.return (Weather_lib.Response.parse json)
end
