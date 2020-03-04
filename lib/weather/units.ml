type t = Standard | Metric | Imperial

let pp fs = function
  | Standard -> ()
  | Metric -> Format.fprintf fs "metric"
  | Imperial -> Format.fprintf fs "imperial"

type time = Unix_UTC

let time _ = Unix_UTC

type temperature = Kelvin | Celsius | Fahrenheit

let temperature = function
  | Standard -> Kelvin
  | Metric -> Celsius
  | Imperial -> Fahrenheit

type percentage = Point

let percentage _ = Point

type atmospheric_pressure = Hectopascal

let atmospheric_pressure _ = Hectopascal

type speed = Meter_per_sec | Miles_per_hour

let speed = function
  | Standard | Metric -> Meter_per_sec
  | Imperial -> Miles_per_hour

type direction = Azimuth_degree

let direction _ = Azimuth_degree

type height = Millimeter

let height _ = Millimeter
