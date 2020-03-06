type coord = { lon : float; lat : float }

type weather = { id : int; main : string; description : string; icon : string }

type main = {
  temp : float;
  feels_like : float;
  temp_min : float;
  temp_max : float;
  pressure : int;
  humidity : int;
  sea_level : int option;
  grnd_level : int option;
}

type wind = { speed : float; deg : float }

type clouds = { all : int }

type rain = { one_h : float; three_h : float option }

type snow = { one_h : float; three_h : float option }

type sys = { country : string; sunrise : int; sunset : int }

type t = {
  coord : coord;
  weather : weather;
  main : main;
  visibility : int;
  wind : wind;
  clouds : clouds;
  rain : rain option;
  snow : snow option;
  dt : int;
  sys : sys;
  timezone : int;
  id : int;
  name : string;
}

module Convert = struct
  open Yojson.Basic
  open Rresult

  let string ~field json =
    match Util.member field json with
    | `String s -> R.ok s
    | `Null -> R.error_msgf "Could not find %S from:\n%a" field pp json
    | _ -> R.error_msgf "Cound not parse %S from:\n%a" field pp json

  let int ~field json =
    match Util.member field json with
    | `Int i -> R.ok i
    | `Null -> R.error_msgf "Could not find %S from:\n%a" field pp json
    | _ -> R.error_msgf "Could not parse %S from:\n%a" field pp json

  let float ~field json =
    match Util.member field json with
    | `Float f -> R.ok f
    | `Int i -> R.ok (float_of_int i)
    | `Null -> R.error_msgf "Could not find %S from:\n%a" field pp json
    | _ -> R.error_msgf "Could not parse %S from:\n%a" field pp json

  let list ~field idx json =
    match Util.member field json with
    | `List l -> (
        match List.nth_opt l idx with
        | Some k -> R.ok k
        | None ->
            R.error_msgf "Could not find %ith element from field %S from:\n%a"
              (idx + 1) field pp json )
    | `Null -> R.error_msgf "Could not find %S from:\n%a" field pp json
    | _ -> R.error_msgf "Could not parse %S from:\n%a" field pp json

  let opt = function Ok x -> Some x | Error _ -> None
end

let parse json =
  let open Yojson.Basic.Util in
  let open Rresult.R.Infix in
  let j = member "coord" json in
  Convert.float ~field:"lon" j >>= fun lon ->
  Convert.float ~field:"lat" j >>= fun lat ->
  Ok { lon; lat } >>= fun coord ->
  Convert.list ~field:"weather" 0 json >>= fun j ->
  Convert.int ~field:"id" j >>= fun id ->
  Convert.string ~field:"main" j >>= fun main ->
  Convert.string ~field:"description" j >>= fun description ->
  Convert.string ~field:"icon" j >>= fun icon ->
  Ok { id; main; description; icon } >>= fun weather ->
  let j = member "main" json in
  Convert.float ~field:"temp" j >>= fun temp ->
  Convert.float ~field:"feels_like" j >>= fun feels_like ->
  Convert.float ~field:"temp_min" j >>= fun temp_min ->
  Convert.float ~field:"temp_max" j >>= fun temp_max ->
  Convert.int ~field:"pressure" j >>= fun pressure ->
  Convert.int ~field:"humidity" j >>= fun humidity ->
  let sea_level = Convert.opt (Convert.int ~field:"sea_level" j) in
  let grnd_level = Convert.opt (Convert.int ~field:"grnd_level" j) in
  Ok
    {
      temp;
      feels_like;
      temp_min;
      temp_max;
      pressure;
      humidity;
      sea_level;
      grnd_level;
    }
  >>= fun main ->
  Convert.int ~field:"visibility" json >>= fun visibility ->
  let j = member "wind" json in
  Convert.float ~field:"speed" j >>= fun speed ->
  Convert.float ~field:"deg" j >>= fun deg ->
  Ok { speed; deg } >>= fun wind ->
  let j = member "clouds" json in
  Convert.int ~field:"all" j >>= fun all ->
  Ok { all } >>= fun clouds ->
  ( try
      let j = member "rain" json in
      Convert.float ~field:"1h" j >>= fun one_h ->
      let three_h = Convert.opt (Convert.float ~field:"3h" j) in
      Ok (Some ({ one_h; three_h } : rain))
    with _ -> Ok None )
  >>= fun rain ->
  ( try
      let j = member "snow" json in
      Convert.float ~field:"1h" j >>= fun one_h ->
      let three_h = Convert.opt (Convert.float ~field:"3h" j) in
      Ok (Some { one_h; three_h })
    with _ -> Ok None )
  >>= fun snow ->
  Convert.int ~field:"dt" json >>= fun dt ->
  let j = member "sys" json in
  Convert.string ~field:"country" j >>= fun country ->
  Convert.int ~field:"sunrise" j >>= fun sunrise ->
  Convert.int ~field:"sunset" j >>= fun sunset ->
  Ok { country; sunrise; sunset } >>= fun sys ->
  Convert.int ~field:"timezone" json >>= fun timezone ->
  Convert.int ~field:"id" json >>= fun id ->
  Convert.string ~field:"name" json >>| fun name ->
  {
    coord;
    weather;
    main;
    visibility;
    wind;
    clouds;
    rain;
    snow;
    dt;
    sys;
    timezone;
    id;
    name;
  }
