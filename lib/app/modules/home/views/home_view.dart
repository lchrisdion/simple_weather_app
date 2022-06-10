import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_weather_app/app/modules/home/views/home_view/home_body.dart';

import '../controllers/home_controller.dart';
import 'home_view/home_weather_info.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: ((context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: Get.width,
              toolbarHeight: kToolbarHeight,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                stretchModes: [StretchMode.blurBackground],
                centerTitle: true,
                background: const HomeWeatherInfo(),
                title: Text(
                  'Medan',
                  style: TextStyle(
                    color: innerBoxIsScrolled ? Colors.black : null,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: innerBoxIsScrolled?Colors.black: Colors.white,
                  ),
                )
              ],
              centerTitle: true,
              primary: true,
              snap: false,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
            ),
          ]),
      body: const HomeBody(),
    ));
  }
}
