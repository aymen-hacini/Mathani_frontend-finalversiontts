import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wird/views/widgets/homepage/feature_tile.dart';

List<Widget> homepageTiles = [
  InkWell(
    onTap: () => Get.toNamed("/quran"),
    child: FeatureTile(
      bgcolor: const Color(0x7FCFFFC6),
      curveEffect: "assets/effects/effect_quran.svg",
      title: "Quran",
      icon: "assets/icons/png/mas7af.png",
    ),
  ),
  InkWell(
    onTap: () => Get.toNamed("/memorize"),
    child: FeatureTile(
      bgcolor: const Color(0x7FFFE4DD),
      curveEffect: "assets/effects/effect_memorize.svg",
      title: "Memorize",
      icon: "assets/icons/png/memorize.png",
    ),
  ),
  InkWell(
    onTap: () => Get.toNamed("/prayertimes"),
    child: FeatureTile(
      bgcolor: const Color(0x4CFFB92C),
      curveEffect: "assets/effects/effect_prayer.svg",
      title: "Prayer Times",
      icon: "assets/icons/png/prayer.png",
    ),
  ),
  InkWell(
    onTap: () => Get.toNamed("/qibla"),
    child: FeatureTile(
      bgcolor: const Color(0x4CFCCE98),
      curveEffect: "assets/effects/effect_qibla.svg",
      title: "Qibla",
      icon: "assets/icons/png/qibla.png",
    ),
  ),
  InkWell(
    onTap: () => Get.toNamed("/duaa"),
    child: FeatureTile(
      bgcolor: const Color(0xFFE2F6F8),
      curveEffect: "assets/effects/effect_duaa.svg",
      title: "Duaa/Hadith",
      icon: "assets/icons/png/duaa.png",
    ),
  ),
];
