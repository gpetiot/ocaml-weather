val by_city_state_country :
  ?lang:Weather_lib.Lang.t ->
  ?units:Weather_lib.Units.t ->
  city_name:string ->
  state:string ->
  country_code:string ->
  api_key:string ->
  (Weather_lib.Response.t, Rresult.R.msg) Result.result Async.Deferred.t

val by_city_state :
  ?lang:Weather_lib.Lang.t ->
  ?units:Weather_lib.Units.t ->
  city_name:string ->
  state:string ->
  api_key:string ->
  (Weather_lib.Response.t, Rresult.R.msg) Result.result Async.Deferred.t

val by_city_name :
  ?lang:Weather_lib.Lang.t ->
  ?units:Weather_lib.Units.t ->
  city_name:string ->
  api_key:string ->
  (Weather_lib.Response.t, Rresult.R.msg) Result.result Async.Deferred.t

val by_city_id :
  ?lang:Weather_lib.Lang.t ->
  ?units:Weather_lib.Units.t ->
  city_id:int ->
  api_key:string ->
  (Weather_lib.Response.t, Rresult.R.msg) Result.result Async.Deferred.t

val by_coord :
  ?lang:Weather_lib.Lang.t ->
  ?units:Weather_lib.Units.t ->
  lat:int ->
  lon:int ->
  api_key:string ->
  (Weather_lib.Response.t, Rresult.R.msg) Result.result Async.Deferred.t

val by_zip_code :
  ?lang:Weather_lib.Lang.t ->
  ?units:Weather_lib.Units.t ->
  ?country_code:string ->
  zip_code:int ->
  api_key:string ->
  (Weather_lib.Response.t, Rresult.R.msg) Result.result Async.Deferred.t
