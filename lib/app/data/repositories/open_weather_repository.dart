import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_weather_app/app/data/models/open_weather_data_model.dart';

class OpenWeatherRepository {
  String _baseUrl = 'https://api.openweathermap.org/data/2.5/onecall';
  Dio dio = Dio();
  Future<OpenWeatherData> getOpenWeatherData({
    required double lat,
    required double lon,
  }) async {
    try {
      var response = await dio.get(
        "$_baseUrl",
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': dotenv.env['OPEN_WEATHER_API_KEY'] ?? "",
          'units': 'metric',
        },
      );
      return OpenWeatherData.fromJson(
        response.data,
      );
    } on DioError catch (e) {
      throw e;
    }
  }
}
