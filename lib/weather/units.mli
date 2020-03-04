type t = Standard | Metric | Imperial

val pp : Format.formatter -> t -> unit

type time = Unix_UTC

val time : t -> time

type temperature = Kelvin | Celsius | Fahrenheit

val temperature : t -> temperature

type percentage = Point

val percentage : t -> percentage

type atmospheric_pressure = Hectopascal

val atmospheric_pressure : t -> atmospheric_pressure

type speed = Meter_per_sec | Miles_per_hour

val speed : t -> speed

type direction = Azimuth_degree

val direction : t -> direction

type height = Millimeter

val height : t -> height
