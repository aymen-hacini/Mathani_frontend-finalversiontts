import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/qiblascreen_controller.dart';

class QiblaScreen extends GetView<QiblahController> {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => QiblahController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiblah Compass'),
      ),
      body: Center(
        child: Obx(() {
          if (!controller.locationPermissionGranted.value) {
            return const Text('Location permission is required');
          }

          return Column(
            children: [
              Text(controller.qiblahDirection.value.offset.toStringAsFixed(3)),
              QiblahCompass(
                qiblahDirection: controller.qiblahDirection.value,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class QiblahCompass extends StatelessWidget {
  final QiblahDirection qiblahDirection;

  const QiblahCompass({super.key, required this.qiblahDirection});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: qiblahDirection.direction * (pi / 180) * -1,
          child: Image.asset("assets/icons/png/compass.png"),
        ),
        Transform.rotate(
          angle: qiblahDirection.qiblah * (pi / 180) * -1,
          child: Image.asset("assets/icons/png/needle.png"),
        ),
      ],
    );
  }
}
