import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GeneralGetStorageService extends GetxService {
  static final box = () => GetStorage();

  final userWeatherData =
      "{\"default_location_name\": \"\", \"weather_data_list\": []}".val(
    'USER_WEATHER_DATA',
    getBox: box,
  );
}
