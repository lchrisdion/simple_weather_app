import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_weather_app/app/modules/home/bindings/home_binding.dart';
import 'package:simple_weather_app/app/ui/theme/app_theme.dart';

import 'app/get_storage_services.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await dotenv.load(fileName: "assets/.env");
  Get.put(GeneralGetStorageService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      initialRoute: Routes.HOME,
      theme: appThemeData,
      getPages: AppPages.routes,
      navigatorKey: Get.key,
    );
  }
}
