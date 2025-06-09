import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/memorizescreen_controller.dart';
import 'package:wird/controllers/quranscreen_controller.dart';
import 'package:wird/views/widgets/quran/surahnametile.dart';

QuranscreenController quranController = Get.find();
MemorizescreenController memorizeController = Get.find();
List<Widget> qurantabs = [
  const Text(
    'Surah',
  ),
  const Text(
    'Tafssir',
  ),
  const Text(
    'Play',
  )
];

List<Widget> memorizetabs = [
  const Text(
    'Surah',
  ),
  const Text(
    'Duaa',
  ),
  const Text(
    'Hadith',
  )
];
List<Widget> duaatabs = [
  const Text(
    'Duaa',
  ),
  const Text(
    'Hadith',
  )
];

List<Widget> tabViews = [
  //Read quran tab view
  Obx(() {
    return quranController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF066C58),
            ),
          )
        : ListView.builder(
            itemCount: quranController.surahs.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var currentsurah = quranController.surahs[index];
              return Surahnametile(
                surahname: currentsurah.arabicName,
                engsurahname: currentsurah.englishName,
                engsurahTranslation: currentsurah.englishTranslation,
                surahNo: currentsurah.number,
                ontap: () {
                  Get.toNamed("/surah",
                      arguments: {"selectedSurahNo": currentsurah.number});
                },
              );
            },
          );
  }),
  //Tafssir quran tab view
  Obx(() {
    return quranController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF066C58),
            ),
          )
        : ListView.builder(
            itemCount: quranController.surahs.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var currentsurah = quranController.surahs[index];
              return Surahnametile(
                surahname: currentsurah.arabicName,
                engsurahname: currentsurah.englishName,
                engsurahTranslation: currentsurah.englishTranslation,
                surahNo: currentsurah.number,
                ontap: () {
                  Get.toNamed("/tafssir",
                      arguments: {"selectedSurahNo": currentsurah.number});
                },
              );
            },
          );
  }),
  // Play audio quran tab view
  Obx(() {
    return quranController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF066C58),
            ),
          )
        : ListView.builder(
            itemCount: quranController.surahs.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var currentsurah = quranController.surahs[index];
              return Surahnametile(
                surahname: currentsurah.arabicName,
                engsurahname: currentsurah.englishName,
                engsurahTranslation: currentsurah.englishTranslation,
                surahNo: currentsurah.number,
                ontap: () {
                  Get.toNamed("/play",
                      arguments: {"selectedSurahNo": currentsurah.number});
                },
              );
            },
          );
  })
];

List<Widget> memorizeTabViews = [
  Obx(() {
    return memorizeController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF066C58),
            ),
          )
        : ListView.builder(
            itemCount: memorizeController.surahs.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var currentsurah = memorizeController.surahs[index];
              return Surahnametile(
                surahname: currentsurah.arabicName,
                engsurahname: currentsurah.englishName,
                engsurahTranslation: currentsurah.englishTranslation,
                surahNo: currentsurah.number,
                ontap: () {
                  Get.toNamed("/learn",
                      arguments: {"selectedSurahNo": currentsurah.number});
                },
              );
            },
          );
  }),
  const Text("duaa"),
  const Text("Hadith")
];

List<Widget> duaatabViews = List.generate(
    2,
    (index) => Obx(() {
          return quranController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF066C58),
                  ),
                )
              : ListView.builder(
                  itemCount: quranController.surahs.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var currentsurah = quranController.surahs[index];
                    return Surahnametile(
                      surahname: currentsurah.arabicName,
                      engsurahname: currentsurah.englishName,
                      engsurahTranslation: currentsurah.englishTranslation,
                      surahNo: currentsurah.number,
                      ontap: () {
                        Get.toNamed("/surah", arguments: {
                          "selectedSurahNo": currentsurah.number
                        });
                      },
                    );
                  },
                );
        }));
