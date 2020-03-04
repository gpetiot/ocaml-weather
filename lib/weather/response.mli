type coord = { lon : int; lat : int }

type weather = { id : int; main : string; description : string; icon : string }

type main = {
  temp : float;
  feels_like : float;
  temp_min : float;
  temp_max : float;
  pressure : int;
  humidity : int;
  sea_level : int;
  grnd_level : int;
}

type wind = { speed : float; deg : float }

type clouds = { all : int }

type rain = { one_h : int; three_h : int }

type snow = { one_h : int; three_h : int }

type sys = { country : string; sunrise : int; sunset : int }

type t = {
  coord : coord;
  weather : weather;
  main : main;
  visibility : int;
  wind : wind;
  clouds : clouds;
  rain : rain;
  snow : snow;
  dt : int;
  sys : sys;
  timezone : int;
  id : int;
  name : string;
}

val parse : Yojson.Basic.t -> (t, Rresult.R.msg) Result.result
