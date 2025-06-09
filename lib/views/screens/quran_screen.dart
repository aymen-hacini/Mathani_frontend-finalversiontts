import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/quranscreen_controller.dart';
import 'package:wird/data/static/Tabs.dart';
import 'package:wird/views/widgets/homepage/lastread_card.dart';

class QuranScreen extends GetView<QuranscreenController> {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => QuranscreenController());
    final appheight = Get.context!.height;
    final appwidth = Get.context!.width;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        flexibleSpace: Opacity(
          opacity: .6,
          child:
              Image.asset("assets/effects/geopattern.png", fit: BoxFit.cover),
        ),
        title: const Text(
          "Quran",
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.w600, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: .6,
                  image: AssetImage("assets/effects/geopattern.png"))),
          height: appheight,
          width: appwidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Section : Last read card
              const Center(child: LastReadCard()),
              TabBar(
                controller: controller.tabController,
                tabs: qurantabs,
                labelColor: const Color(0xFF066C58),
                unselectedLabelColor: const Color(0xB2004B40),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
                unselectedLabelStyle: const TextStyle(
                  color: Color(0xB2004B40),
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                indicatorColor: const Color(0xFF076D59),
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: const EdgeInsets.only(top: 25, bottom: 8),
                onTap: (tabIndex) {},
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  physics: const BouncingScrollPhysics(),
                  children: tabViews,
                ),
              )
            ],
          )),
    );
  }
}
