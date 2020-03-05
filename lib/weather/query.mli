type t = ?lang:Lang.t -> ?units:Units.t -> api_key:string -> Uri.t

val by_city_state_country :
  city_name:string -> state:string -> country_code:string -> t

val by_city_state : city_name:string -> state:string -> t

val by_city_name : city_name:string -> t

val by_city_id : city_id:int -> t

val by_coord : lat:int -> lon:int -> t

val by_zip_code : ?country_code:string -> zip_code:int -> t
