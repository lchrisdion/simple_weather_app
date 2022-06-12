import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_weather_app/app/modules/home/controllers/home_controller.dart';
import 'package:simple_weather_app/app/ui/theme/app_theme.dart';

class HomeWeatherInfo extends GetView<HomeController> {
  const HomeWeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        30,
        MediaQuery.of(context).padding.top + 20,
        30,
        0,
      ),
      color: appThemeData.primaryColor,
      child: Obx(
        () {
          var currentWeather = controller.selectedWeatherData.value;
          return controller.isNoInternetConnection.value
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      currentWeather.weather ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${currentWeather.lat ?? ""} , ${currentWeather.lon ?? ""}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${currentWeather.temperature ?? 0.0}°',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              15,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Pressure',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${currentWeather.pressure ?? 0} hPa',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                left: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Wind',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${currentWeather.windSpeed ?? 0.0} km/h',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${currentWeather.humidity ?? 0.0} %',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kToolbarHeight * 1.5,
                    )
                  ],
                );
        },
      ),
    );
  }
}
