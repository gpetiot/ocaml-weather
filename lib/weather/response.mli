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

type wind = { speed : float; deg : float option }

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

val parse : Yojson.Basic.t -> (t, Rresult.R.msg) Result.result
