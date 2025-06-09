import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FeatureTile extends StatelessWidget {
  final Color bgcolor;
  final String curveEffect;
  final String title;
  final String icon;
  FeatureTile({
    super.key,
    required this.bgcolor,
    required this.curveEffect,
    required this.title,
    required this.icon,
  });

  final appheight = Get.context!.height;
  final appwidth = Get.context!.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: appwidth * .03, vertical: appheight * .01),
      height: appheight * .2,
      width: appwidth * .4,
      decoration: ShapeDecoration(
        color: bgcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.78),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: appheight * .02,
            left: appwidth * .05,
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF004B40),
                fontSize: 19.70,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          Positioned(
              bottom: appheight * .04,
              right: appwidth * .04,
              child: Image.asset(
                icon,
                fit: BoxFit.contain,
              )),
          Positioned(
              bottom: 0,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(25.78),
                      bottomLeft: Radius.circular(25.78)),
                  child: SvgPicture.asset(curveEffect)))
        ],
      ),
    );
  }
}
