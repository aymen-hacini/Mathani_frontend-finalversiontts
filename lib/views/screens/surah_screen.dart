import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/surahscreen_controller.dart';

class SurahScreen extends GetView<SurahscreenController> {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SurahscreenController());
    final appheight = Get.context!.height;
    final appwidth = Get.context!.width;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          toolbarHeight: appheight * .15,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      controller.selectedSurah.value.arabicName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ))
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.30000001192092896),
              ),
              SvgPicture.asset(
                "assets/icons/svg/bs.svg",
                fit: BoxFit.cover,
                height: 30,
                width: appwidth,
              ),
              const Text(
                'Juz 6 / Hizb 11 - Page 106',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              )
            ],
          ),
          flexibleSpace: SizedBox(
            height: 999,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: appwidth,
                    height: appheight * .19,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-0.99, 0.12),
                        end: Alignment(0.99, -0.12),
                        colors: [Color(0xFF006754), Color(0xFF87D1A4)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1E006754),
                          blurRadius: 15,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    "assets/effects/shallow_mashaf.svg",
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    "assets/effects/effect_appbar.svg",
                    width: appwidth,
                    height: appheight * .11,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (String value) {
                // Handle the selected value
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'bookmark',
                    child: Text('Bookmark'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'share',
                    child: Text('Share'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'translate',
                    child: Text('Translate'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          width: appwidth,
          height: appheight,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff87D1A4), width: 2)),
          child: Container(
            width: appwidth,
            height: appheight,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff87D1A4), width: 2)),
            child: Obx(
              () => controller.surahPages.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.surahPages.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                controller.surahPages[index],
                                style: const TextStyle(
                                  color: Color(0xFF004B40),
                                  fontSize: 20,
                                  fontFamily: 'Amiri',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ));
  }
}
