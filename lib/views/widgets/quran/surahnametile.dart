import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Surahnametile extends StatelessWidget {
  final String surahname;
  final String engsurahname;
  final String engsurahTranslation;
  final int surahNo;
  final VoidCallback ontap;
  const Surahnametile({
    super.key,
    required this.surahname,
    required this.surahNo,
    required this.ontap,
    required this.engsurahname,
    required this.engsurahTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        engsurahname,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
      subtitle: Text(
        engsurahTranslation,
        style: const TextStyle(
          color: Color(0xFF848484),
          fontSize: 12,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
      leading: Container(
        width: 36,
        height: 36,
        decoration: ShapeDecoration(
          color: const Color(0xFF87D1A4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
        child: Center(
          child: Text(
            surahNo.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
      trailing: Text(
        surahname,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Color(0xFF076C58),
          fontSize: 20,
          fontFamily: 'Amiri',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
      onTap: ontap,
    );
  }
}
