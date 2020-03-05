open Rresult.R.Infix

let handle_call uri =
  let url = Uri.to_string uri in
  ( match Curly.(run ~args:[] (Request.make ~url ~meth:`GET ())) with
  | Ok x -> Ok x
  | Error e -> Rresult.R.error_msgf "curl execution failed: %a" Curly.Error.pp e
  )
  >>= fun { body; _ } ->
  match Yojson.Basic.from_string body with
  | exception Yojson.Json_error msg -> Rresult.R.error_msg msg
  | json -> Weather_lib.Response.parse json

let by_city_state_country ?lang ?units ~city_name ~state ~country_code ~api_key
    =
  Weather_lib.Query.by_city_state_country ?lang ?units ~city_name ~state
    ~country_code ~api_key
  |> handle_call

let by_city_state ?lang ?units ~city_name ~state ~api_key =
  Weather_lib.Query.by_city_state ?lang ?units ~city_name ~state ~api_key
  |> handle_call

let by_city_name ?lang ?units ~city_name ~api_key =
  Weather_lib.Query.by_city_name ?lang ?units ~city_name ~api_key |> handle_call

let by_city_id ?lang ?units ~city_id ~api_key =
  Weather_lib.Query.by_city_id ?lang ?units ~city_id ~api_key |> handle_call

let by_coord ?lang ?units ~lat ~lon ~api_key =
  Weather_lib.Query.by_coord ?lang ?units ~lat ~lon ~api_key |> handle_call

let by_zip_code ?lang ?units ?country_code ~zip_code ~api_key =
  Weather_lib.Query.by_zip_code ?lang ?units ?country_code ~zip_code ~api_key
  |> handle_call
