import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_weather_app/app/modules/home/views/home_view/home_body.dart';
import 'package:simple_weather_app/app/ui/theme/app_theme.dart';
import 'package:simple_weather_app/app/ui/widgets/home_search_dialog.dart';

import '../controllers/home_controller.dart';
import 'home_view/home_weather_info.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isFetching.value
            ? Center(
                child: CircularProgressIndicator(
                  color: appThemeData.primaryColor,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshPage();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                      ),
                      expandedHeight: Get.width,
                      toolbarHeight: kToolbarHeight,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        stretchModes: [StretchMode.blurBackground],
                        centerTitle: true,
                        background: const HomeWeatherInfo(),
                        title: Obx(
                          () => Text(
                            controller.isNoInternetConnection.value
                                ? "You are offline"
                                : controller.selectedWeatherData.value
                                        .locationName ??
                                    "",
                          ),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () async {
                            // controller.addWeather(
                            //   lat: 37.4219,
                            //   lon: -122.0841,
                            // );
                            await Get.dialog(HomeSearchDialog());
                            controller.searchLocationTextValue.value = "";
                            controller.searchLocationController.clear();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      ],
                      centerTitle: true,
                      primary: true,
                      snap: false,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: false,
                      backgroundColor: appThemeData.primaryColor,
                      surfaceTintColor: appThemeData.primaryColor,
                    ),
                    const HomeBody(),
                  ],
                ),
              ),
      ),
    );
  }
}
