import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LastReadCard extends StatelessWidget {
  const LastReadCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appheight = Get.context!.height;
    final appwidth = Get.context!.width;
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        gradient: const LinearGradient(
          begin: Alignment(0.99, -0.12),
          end: Alignment(-0.99, 0.12),
          colors: [Color(0xFF006754), Color(0xFF87D1A4)],
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1E006754),
            blurRadius: 15,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      height: appheight * .23,
      width: appwidth * .88,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23)),
                  child: SvgPicture.asset("assets/effects/curve.svg"))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(left: appwidth * .05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Last Recite",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "الفاتحة",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Amiri",
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      "Aya no.1",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFAF6EB),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 10, right: 25)),
                        onPressed: () {},
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
              SvgPicture.asset(
                "assets/icons/svg/lastreadicon.svg",
                fit: BoxFit.cover,
              ),
            ],
          ),
          Positioned(
            top: appheight * .03,
            right: appwidth * .16,
            child: SvgPicture.asset(
              "assets/effects/star1.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: appheight * .09,
            right: appwidth * .4,
            child: SvgPicture.asset(
              "assets/effects/star2.svg",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
