import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart' as googlePlace;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_weather_app/app/data/repositories/open_weather_repository.dart';
import 'package:simple_weather_app/app/get_storage_services.dart';
import '../../../data/models/weather_data_model.dart';
import '../../../utils/helper.dart';

class HomeController extends GetxController {
  final OpenWeatherRepository openWeatherRepository = OpenWeatherRepository();
  final GeneralGetStorageService getStorageService = Get.find();
  final searchLocationController = TextEditingController();
  final searchLocationTextValue = "".obs;
  late Worker searchLocationWorker = debounce(
    searchLocationTextValue,
    (_) {
      searchByKeyword();
    },
    time: Duration(
      milliseconds: 500,
    ),
  );
  final googlePlaceResult = googlePlace.TextSearchResponse().obs;
  final selectedWeatherData = WeatherData().obs;
  final userWeatherData = UserWeatherData().obs;
  Location currentLocation = Location();
  final currentLatitude = 0.0.obs;
  final currentLongtitude = 0.0.obs;
  final currentLocationName = "".obs;
  final isNoInternetConnection = false.obs;
  final isFetching = false.obs;
  final isRefreshing = false.obs;
  @override
  void onInit() async {
    super.onInit();
    print('inii ${dotenv.env['OPEN_WEATHER_API_KEY']}');
    isFetching.value = true;
    if (await getLocationPermission()) {
      await getLocation();
      // await Future.delayed(Duration(
      //   seconds: 1,
      // ));
      await getCurrentWeather();
    }
    isFetching.value = false;
    searchLocationWorker = searchLocationWorker;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  refreshPage() async {
    isRefreshing.value = true;
    if (await getLocationPermission()) {
      await getLocation();
      // await Future.delayed(Duration(
      //   seconds: 1,
      // ));
      await getCurrentWeather();
    }
    searchLocationWorker = searchLocationWorker;
    isRefreshing.value = false;
  }

  Future<bool> getLocationPermission() async {
    try {
      await Permission.location.request();
      if (await Permission.location.status.isGranted) {
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  getLocation() async {
    try {
      LocationData location = await currentLocation.getLocation();
      currentLatitude.value = location.latitude ?? 0.0;
      currentLongtitude.value = location.longitude ?? 0.0;
      var currentLocationDetail = await Helper.getLocationSubdistrictName(
          lat: location.latitude ?? 0.0, long: location.longitude ?? 0.0);
      currentLocationName.value = currentLocationDetail;
    } catch (e) {
      print(e);
    }
  }

  getCurrentWeather() async {
    try {
      isNoInternetConnection.value = false;
      userWeatherData.value = UserWeatherData.fromJson(
          json.decode((getStorageService.userWeatherData.val)));
      if (userWeatherData.value.defaultLocationName == "") {
        var response = await openWeatherRepository.getOpenWeatherData(
          lat: currentLatitude.value,
          lon: currentLongtitude.value,
        );
        var responseWeatherData = WeatherData(
          lat: response.lat,
          lon: response.lon,
          temperature: response.current?.temp,
          humidity: response.current?.humidity,
          locationName: currentLocationName.value,
          pressure: response.current?.pressure,
          windSpeed: response.current?.windSpeed,
          weather: response.current?.weather?.first.main ?? "",
        );
        selectedWeatherData.value = responseWeatherData;
        userWeatherData.value = UserWeatherData(
          defaultLocationName: currentLocationName.value,
          weatherDataList: [
            responseWeatherData,
            WeatherData(
              lat: -2.9716,
              lon: 104.7754,
              locationName: 'Palembang',
            ),
            WeatherData(
              lat: -6.2088,
              lon: 106.8456,
              locationName: 'Jakarta',
            ),
          ],
        );
      } else {
        selectedWeatherData.value = userWeatherData.value.weatherDataList
                ?.firstWhere((weather) =>
                    weather.locationName ==
                    userWeatherData.value.defaultLocationName) ??
            WeatherData();
      }
    } catch (e) {
      print(e);
      if (userWeatherData.value.defaultLocationName == "") {
        var weatherData = WeatherData(
          lat: currentLatitude.value,
          lon: currentLongtitude.value,
          locationName: currentLocationName.value,
        );
        selectedWeatherData.value = weatherData;
        userWeatherData.value = UserWeatherData(
          defaultLocationName: currentLocationName.value,
          weatherDataList: [
            weatherData,
            WeatherData(
              lat: -2.9716,
              lon: 104.7754,
              locationName: 'Palembang',
            ),
            WeatherData(
              lat: -6.2088,
              lon: 106.8456,
              locationName: 'Jakarta',
            ),
          ],
        );
        isNoInternetConnection.value = true;
      }
    }
  }

  addWeather({
    required double lat,
    required double lon,
    String? locName,
  }) async {
    try {
      var locationName = locName ??
          await Helper.getLocationSubdistrictName(lat: lat, long: lon);
      if ((userWeatherData.value.weatherDataList
                  ?.where((location) => location.locationName == locationName)
                  .map((e) => e) ??
              [])
          .isEmpty) {
        var response = await openWeatherRepository.getOpenWeatherData(
          lat: lat,
          lon: lon,
        );
        var currentWeatherDataList = userWeatherData.value.weatherDataList;
        userWeatherData.value = UserWeatherData(
          defaultLocationName: locationName,
          weatherDataList: [
            WeatherData(
              lat: response.lat,
              lon: response.lon,
              temperature: response.current?.temp,
              humidity: response.current?.humidity,
              locationName: locationName,
              pressure: response.current?.pressure,
              windSpeed: response.current?.windSpeed,
              weather: response.current?.weather?.first.main ?? "",
            ),
            ...currentWeatherDataList ?? [],
          ],
        );
        selectedWeatherData.value = WeatherData(
          lat: response.lat,
          lon: response.lon,
          temperature: response.current?.temp,
          humidity: response.current?.humidity,
          locationName: locationName,
          pressure: response.current?.pressure,
          windSpeed: response.current?.windSpeed,
          weather: response.current?.weather?.first.main ?? "",
        );
        setLocalUserWeatherDataValue();
      } else {
        //ALERT LOCATION ALREADY EXISTS;
      }
    } catch (e) {
      print(e);
    }
  }

  removeLocation({
    required String locationName,
  }) async {
    try {
      userWeatherData.value.weatherDataList
          ?.removeWhere((weather) => weather.locationName == locationName);
      if (userWeatherData.value.defaultLocationName == locationName) {
        if ((userWeatherData.value.weatherDataList ?? []).isEmpty)
          userWeatherData.value.defaultLocationName = "";
        else {
          selectedWeatherData.value =
              userWeatherData.value.weatherDataList!.first;
          userWeatherData.value.defaultLocationName =
              userWeatherData.value.weatherDataList?.first.locationName;
        }
      }
      setLocalUserWeatherDataValue();
      await getCurrentWeather();
    } catch (e) {
      print(e);
    }
  }

  selectWeatherData(WeatherData weatherData) async {
    try {
      selectedWeatherData.value = weatherData;
      userWeatherData.value.defaultLocationName = weatherData.locationName;
      setLocalUserWeatherDataValue();
    } catch (e) {}
  }

  setLocalUserWeatherDataValue() {
    getStorageService.userWeatherData.val =
        userWeatherData.value.toJson().toString();
    print(getStorageService.userWeatherData.val);
  }

  searchByKeyword() async {
    try {
      googlePlaceResult.value = await googlePlace.GooglePlace(
            dotenv.env['MAPS_API_KEY'] ?? "",
          ).search.getTextSearch(searchLocationTextValue.value) ??
          googlePlace.TextSearchResponse();
    } catch (e) {
      googlePlaceResult.value = googlePlace.TextSearchResponse();
    }
  }
}
