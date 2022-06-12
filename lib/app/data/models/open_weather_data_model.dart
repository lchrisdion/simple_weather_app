class OpenWeatherData {
  OpenWeatherData({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
  });

  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  Current? current;

  factory OpenWeatherData.fromJson(Map<String, dynamic> json) =>
      OpenWeatherData(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        timezone: json["timezone"] == null ? null : json["timezone"],
        timezoneOffset:
            json["timezone_offset"] == null ? null : json["timezone_offset"],
        current:
            json["current"] == null ? null : Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "timezone": timezone == null ? null : timezone,
        "timezone_offset": timezoneOffset == null ? null : timezoneOffset,
        "current": current == null ? null : current?.toJson(),
      };
}

class Current {
  Current({
    this.temp,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.weather,
  });

  double? temp;

  int? pressure;
  int? humidity;

  double? windSpeed;
  List<Weather>? weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        temp: json["temp"] == null ? null : json["temp"].toDouble(),
        pressure: json["pressure"] == null ? null : json["pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        windSpeed:
            json["wind_speed"] == null ? null : json["wind_speed"].toDouble(),
        weather: json["weather"] == null
            ? null
            : List<Weather>.from(
                json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp == null ? null : temp,
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "wind_speed": windSpeed == null ? null : windSpeed,
        "weather": weather == null
            ? null
            : List<dynamic>.from(weather?.map((x) => x.toJson()) ?? []),
      };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] == null ? null : json["id"],
        main: json["main"] == null ? null : json["main"],
        description: json["description"] == null ? null : json["description"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "main": main == null ? null : main,
        "description": description == null ? null : description,
        "icon": icon == null ? null : icon,
      };
}
