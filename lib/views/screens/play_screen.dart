import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/playscreen_controller.dart';

class PlayScreen extends GetView<PlayscreenController> {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PlayscreenController());
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
            "Play ",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined))
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
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final position = controller.position.value;
                final duration = controller.duration.value;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        'Surah : ${controller.selectedSurah.value.arabicName}',
                      ),
                    ),
                    const SizedBox(height: 20),
                    controller.selectedSurah.value.revelationType == "Meccan"
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/icons/jpg/makkah.jpg',
                              height: appheight * .4,
                              width: appwidth * .4,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/icons/jpg/madinah.jpg',
                              height: appheight * .4,
                              width: appwidth * .7,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appwidth * .1),
                      child: Slider(
                        value: controller.position.value.inSeconds.toDouble(),
                        min: 0.0,
                        max: controller.duration.value.inSeconds.toDouble(),
                        activeColor: const Color(0xFF004B40),
                        inactiveColor: const Color(0xFF00A056),
                        onChanged: (value) {
                          final position = Duration(seconds: value.toInt());
                          controller.seekAudio(position);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          position.toString().split('.').first,
                          style: const TextStyle(
                            color: Color(0xFF02AA77),
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                          ),
                        ),
                        Text(
                          duration.toString().split('.').first,
                          style: const TextStyle(
                            color: Color(0xFF02AA77),
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () => controller.playAudio(),
                            icon: const Icon(
                              Icons.settings,
                              size: 36,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.playAudio(),
                          icon: const Icon(
                            Icons.fast_rewind_rounded,
                            size: 36,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.playAudio(),
                          icon: const Icon(
                            Icons.play_circle_fill,
                            size: 36,
                            color: Color(0xFF02AA77),
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.pauseRecitation(),
                          icon: const Icon(
                            Icons.pause_circle_filled,
                            size: 36,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.fastForwardToNextSurah(),
                          icon: const Icon(
                            Icons.fast_forward,
                            size: 36,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              controller.toggleRepeatMode();
                            },
                            icon: controller.isrepeating.value
                                ? const Icon(
                                    Icons.repeat_rounded,
                                    size: 36,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.repeat_on,
                                    size: 36,
                                    color: Colors.black,
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
            })));
  }
}
