import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_weather_app/app/data/models/weather_data_model.dart';
import 'package:simple_weather_app/app/modules/home/controllers/home_controller.dart';
import 'package:simple_weather_app/app/modules/home/controllers/home_weather_card_controller.dart';

import '../../../../ui/widgets/home_weather_card.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Get.lazyPut(
                () => HomeWeatherCardController(
                    defaultWeatherData: controller
                            .userWeatherData.value.weatherDataList?[index] ??
                        WeatherData()),
                tag: (controller.userWeatherData.value.weatherDataList?[index]
                        .locationName ??
                    ""),
              );
              return Obx(
                () => HomeWeatherCard(
                  onRemove: () async {
                    if (!controller.isNoInternetConnection.value)
                      controller.removeLocation(
                          locationName: controller.userWeatherData.value
                                  .weatherDataList?[index].locationName ??
                              "");
                  },
                  isSelected: controller.isNoInternetConnection.value
                      ? false
                      : controller.selectedWeatherData.value.locationName ==
                          controller.userWeatherData.value
                              .weatherDataList?[index].locationName,
                  tag: (controller.userWeatherData.value.weatherDataList?[index]
                          .locationName ??
                      ""),
                ),
              );
            },
            childCount:
                controller.userWeatherData.value.weatherDataList?.length ?? 0,
          ),
        ),
      ),
    );
  }
}
