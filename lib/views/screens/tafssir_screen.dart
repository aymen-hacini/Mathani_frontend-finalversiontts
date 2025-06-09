import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/tafssirscreen_controller.dart';
import 'package:wird/data/models/tafssirbook.dart';

class TafssirScreen extends GetView<TafssirscreenController> {
  const TafssirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TafssirscreenController());
    final appheight = Get.context!.height;
    final appwidth = Get.context!.width;
    final int surahNumber = Get.arguments['selectedSurahNo'];

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
            ],
          ),
          actions: [
            PopupMenuButton<TafsirBook>(
              onSelected: (TafsirBook book) {
                controller.selectedTafsirBook.value = book;
                controller.refreshTafsir(surahNumber);
              },
              itemBuilder: (BuildContext context) {
                return controller.tafsirBooks.map((TafsirBook book) {
                  return PopupMenuItem<TafsirBook>(
                    value: book,
                    child: Text(book.name),
                  );
                }).toList();
              },
              icon: const Icon(Icons.menu_book),
            )
          ],
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
        ),
        body: Container(
            decoration: const BoxDecoration(
                color: Color(0xFFECF3F2),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: .6,
                    image: AssetImage("assets/effects/geopattern.png"))),
            height: appheight,
            width: appwidth,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        itemCount: controller.selectedSurah.value.ayahs.length,
                        itemBuilder: (context, index) {
                          var ayah =
                              controller.selectedSurah.value.ayahs[index];
                          return ListTile(
                            title: Text(
                              "${ayah.text} \uFD3F ${ayah.numberInSurah} \uFD3E ",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFF004B40),
                                fontSize: 20,
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            subtitle: Text(
                              ayah.tafssir,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                color: Color(0xFF004B40),
                                fontSize: 14,
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          );
                        })))));
  }
}
