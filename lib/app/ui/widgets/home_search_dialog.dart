import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:simple_weather_app/app/modules/home/controllers/home_controller.dart';

class HomeSearchDialog extends GetView<HomeController> {
  const HomeSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      height: kToolbarHeight,
                      child: IconButton(
                        onPressed: Get.back,
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: controller.searchLocationController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.my_location,
                              ),
                              onPressed: () {
                                controller.searchLocationController.text =
                                    controller.currentLocationName.value;
                                controller.searchLocationTextValue.value =
                                    controller.currentLocationName.value;
                              },
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            hintText: 'Search Location',
                          ),
                          onChanged: (value) {
                            controller.searchLocationTextValue.value = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var result = controller
                                .googlePlaceResult.value.results?[index] ??
                            SearchResult();
                        return GestureDetector(
                          onTap: () async {
                            if (result.geometry?.location?.lat != null &&
                                result.geometry?.location?.lng != null)
                              await controller.addWeather(
                                lat: result.geometry!.location!.lat!,
                                lon: result.geometry!.location!.lng!,
                                locName: result.name,
                              );
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            child: Text(
                              result.name ?? "",
                            ),
                          ),
                        );
                      },
                      itemCount:
                          controller.googlePlaceResult.value.results?.length ??
                              0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
