import 'package:get/get.dart';
import 'package:simple_weather_app/app/data/models/weather_data_model.dart';
import 'package:simple_weather_app/app/data/repositories/open_weather_repository.dart';
import 'package:simple_weather_app/app/modules/home/controllers/home_controller.dart';

class HomeWeatherCardController extends GetxController {
  final WeatherData defaultWeatherData;
  final OpenWeatherRepository openWeatherRepository = OpenWeatherRepository();
  HomeWeatherCardController({
    required this.defaultWeatherData,
  });
  late final weatherData = defaultWeatherData.obs;
  final HomeController homeController = Get.find();
  late Worker refreshWorker = ever(homeController.isRefreshing, (_) {
    if (homeController.isRefreshing.value) {
      getCurrentWeather();
    }
  });

  @override
  void onInit() {
    super.onInit();
    getCurrentWeather();
    refreshWorker = refreshWorker;
  }

  getCurrentWeather() async {
    try {
      var response = await openWeatherRepository.getOpenWeatherData(
        lat: weatherData.value.lat!,
        lon: weatherData.value.lon!,
      );

      var updatedWeatherData = WeatherData(
        lat: response.lat,
        lon: response.lon,
        temperature: response.current?.temp,
        humidity: response.current?.humidity,
        locationName: weatherData.value.locationName,
        pressure: response.current?.pressure,
        windSpeed: response.current?.windSpeed,
        weather: response.current?.weather?.first.main ?? "",
      );
      weatherData.value = updatedWeatherData;
      var userWeatherIndex = homeController
          .userWeatherData.value.weatherDataList
          ?.indexWhere((weather) =>
              weather.locationName == weatherData.value.locationName);
      if (userWeatherIndex != null)
        homeController.userWeatherData.value
            .weatherDataList?[userWeatherIndex] = weatherData.value;
    } catch (e) {
      print(e);
    }
  }
}
