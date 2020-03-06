# ocaml-weather -- an OCaml library for accessing weather data

ocaml-weather is an OCaml library to access weather data from [OpenWeather's API](https://openweathermap.org/api).

So far it only supports the [Current weather data](https://openweathermap.org/current) feature, that is available for free accounts. To use it, you must first request a free [API key](https://openweathermap.org/home/sign_up). We are not affiliated with OpenWeather, but having an API key and accepting their User Terms of Service is required to access the API.

ocaml-weather provides implementations for several asynchronous programming libraries:
- `Weather_lwt` uses the [Lwt](https://ocsigen.org/lwt/) library.
- `Weather_lwt_unix` uses the Unix bindings of the Lwt library.
- `Weather_async` uses the [Async](https://realworldocaml.org/v1/en/html/concurrent-programming-with-async.html) library.
- `Weather_mirage` (experimental) uses a [Mirage](https://mirage.io/) interface so that it can be part of unikernels, this backend is still in progress.

A synchronous library `Weather` is also exposed that relies on `curl` to access the OpenWeather API.

Examples are provided for each backend:
- [`Weather` example](examples/weather/)
- [`Weather_lwt` example](examples/weather-lwt/)
- [`Weather_lwt_unix` example](examples/weather-lwt-unix/)
- [`Weather_async` example](examples/weathers-async/)
- [`Weather_mirage` example](examples/weathers-mirage/)
