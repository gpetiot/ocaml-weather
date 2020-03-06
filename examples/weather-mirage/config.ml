open Mirage

let main =
  foreign
    ~packages:[ package "weather-mirage" ]
    ~deps:[ abstract nocrypto ] "Unikernel" job

let () = register "weather" [ main ]
