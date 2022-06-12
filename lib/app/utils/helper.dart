import 'package:geocoding/geocoding.dart';

class Helper {
  static Future<String> getLocationSubdistrictName(
      {required double lat, required double long}) async {
    var currentLocationDetail = await placemarkFromCoordinates(
      lat,
      long,
    );
    return currentLocationDetail.first.subAdministrativeArea ?? "";
  }
}
