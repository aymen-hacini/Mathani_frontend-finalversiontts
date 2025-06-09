import 'package:get/get.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import 'package:location/location.dart';

class QiblahController extends GetxController {
  var qiblahDirection = const QiblahDirection(0, 0, 0).obs;
  var locationPermissionGranted = false.obs;
  final Location location = Location();

  @override
  void onInit() {
    super.onInit();
    checkLocationPermission();
  }

  void checkLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationPermissionGranted.value = true;
    _initQiblah();
  }

  void _initQiblah() {
    FlutterQiblah.qiblahStream.listen((qiblahDirectionData) {
      print("the value is : ${qiblahDirectionData.qiblah}");
      qiblahDirection.value = qiblahDirectionData; // Convert to radians
    });
  }
}
