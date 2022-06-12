import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAlertDialog extends StatelessWidget {
  const HomeAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Location has already added',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: Get.back,
              child: Text('Ok'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(Get.width / 4, 36),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
