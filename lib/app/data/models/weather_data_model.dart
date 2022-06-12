class UserWeatherData {
  UserWeatherData({
    this.defaultLocationName,
    this.weatherDataList,
  });

  String? defaultLocationName;
  List<WeatherData>? weatherDataList;

  factory UserWeatherData.fromJson(Map<String, dynamic> json) =>
      UserWeatherData(
        defaultLocationName: json["default_location_name"] == null
            ? null
            : json["default_location_name"],
        weatherDataList: json["weather_data_list"] == null
            ? null
            : List<WeatherData>.from(
                json["weather_data_list"].map((x) => WeatherData.fromJson(x)) ??
                    []),
      );

  Map<String, dynamic> toJson() => {
        "\"default_location_name\"":
            defaultLocationName == null ? null : "\"$defaultLocationName\"",
        "\"weather_data_list\"": weatherDataList == null
            ? null
            : List<dynamic>.from(weatherDataList?.map((x) => x.toJson()) ?? []),
      };
}

class WeatherData {
  WeatherData({
    this.lat,
    this.lon,
    this.locationName,
    this.temperature,
    this.humidity,
    this.windSpeed,
    this.pressure,
    this.weather,
  });

  double? lat;
  double? lon;
  String? locationName;
  double? temperature;
  int? humidity;
  double? windSpeed;
  int? pressure;
  String? weather;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        lat: json["lat"] == null ? null : json["lat"],
        lon: json["lon"] == null ? null : json["lon"],
        locationName:
            json["location_name"] == null ? null : json["location_name"],
        temperature: json["temperature"] == null ? null : json["temperature"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        windSpeed: json["wind_speed"] == null ? null : json["wind_speed"],
        pressure: json["pressure"] == null ? null : json["pressure"],
        weather: json["weather"] == null ? null : json["weather"],
      );

  Map<String, dynamic> toJson() => {
        "\"lat\"": lat == null ? null : lat,
        "\"lon\"": lon == null ? null : lon,
        "\"location_name\"": locationName == null ? null : "\"$locationName\"",
        "\"temperature\"": temperature == null ? null : temperature,
        "\"humidity\"": humidity == null ? null : humidity,
        "\"wind_speed\"": windSpeed == null ? null : windSpeed,
        "\"pressure\"": pressure == null ? null : pressure,
        "\"weather\"": weather == null ? null : "\"$weather\"",
      };
}
