type t = ?lang:Lang.t -> ?units:Units.t -> api_key:string -> Uri.t

let generic_uri ?(lang = Lang.english) ?(units = Units.Standard) ~api_key ~query
    =
  Uri.make ~scheme:"https" ~host:"api.openweathermap.org"
    ~path:"/data/2.5/weather"
    ~query:
      ( query
      @ [
          ("appid", [ api_key ]);
          ("lang", [ Format.asprintf "%a" Lang.pp lang ]);
          ("units", [ Format.asprintf "%a" Units.pp units ]);
        ] )
    ()

let to_int s = Format.asprintf "%i" s

let by_city_state_country ~city_name ~state ~country_code =
  generic_uri ~query:[ ("q", [ city_name; state; country_code ]) ]

let by_city_state ~city_name ~state =
  generic_uri ~query:[ ("q", [ city_name; state ]) ]

let by_city_name ~city_name = generic_uri ~query:[ ("q", [ city_name ]) ]

let by_city_id ~city_id = generic_uri ~query:[ ("id", [ to_int city_id ]) ]

let by_coord ~lat ~lon =
  generic_uri ~query:[ ("lat", [ to_int lat ]); ("lon", [ to_int lon ]) ]

let by_zip_code ?(country_code = "us") ~zip_code =
  generic_uri ~query:[ ("zip", [ to_int zip_code; country_code ]) ]
