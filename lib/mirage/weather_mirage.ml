module Make (Ch : Mirage_channel.S) = struct
  module IO = Cohttp_mirage.IO (Ch)
  module Client = Cohttp_mirage.Client

  let handle_call uri =
    let open IO in
    Client.get uri >>= fun (_, body) ->
    Cohttp_lwt.Body.to_string body >>= fun body ->
    match Yojson.Basic.from_string body with
    | exception Yojson.Json_error msg -> IO.return (Rresult.R.error_msg msg)
    | json -> IO.return (Weather_lib.Response.parse json)

  let by_city_state_country ?lang ?units ~city_name ~state ~country_code
      ~api_key =
    Weather_lib.Query.by_city_state_country ?lang ?units ~city_name ~state
      ~country_code ~api_key
    |> handle_call

  let by_city_state ?lang ?units ~city_name ~state ~api_key =
    Weather_lib.Query.by_city_state ?lang ?units ~city_name ~state ~api_key
    |> handle_call

  let by_city_name ?lang ?units ~city_name ~api_key =
    Weather_lib.Query.by_city_name ?lang ?units ~city_name ~api_key
    |> handle_call

  let by_city_id ?lang ?units ~city_id ~api_key =
    Weather_lib.Query.by_city_id ?lang ?units ~city_id ~api_key |> handle_call

  let by_coord ?lang ?units ~lat ~lon ~api_key =
    Weather_lib.Query.by_coord ?lang ?units ~lat ~lon ~api_key |> handle_call

  let by_zip_code ?lang ?units ?country_code ~zip_code ~api_key =
    Weather_lib.Query.by_zip_code ?lang ?units ?country_code ~zip_code ~api_key
    |> handle_call
end
