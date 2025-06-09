import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wird/data/models/surah.dart';

class SurahscreenController extends GetxController
    with GetTickerProviderStateMixin {
  late PageController pageController;
  var selectedSurah = Surah(
          number: 0,
          englishName: '',
          arabicName: '',
          ayahs: [],
          englishTranslation: '',
          revelationType: "")
      .obs;

  var isLoading = true.obs;
  var surahPages = [].obs;
  late int selectedSurahNo;

  var allAyas = ''.obs;
  @override
  void onInit() {
    int selectedSurahNo = Get.arguments["selectedSurahNo"];
    pageController = PageController();
    fetchSurahAyahs(selectedSurahNo);

    super.onInit();
  }

  void fetchSurahAyahs(int surahNumber) async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse('http://api.alquran.cloud/v1/surah/$surahNumber'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        selectedSurah(Surah.fromJson(jsonResponse['data']));
        selectedSurah.value.number ==
                1 // if the surah is al fatiha then keep basmala
            ? allAyas.value = selectedSurah.value.ayahs
                .map((i) =>
                    i.text.replaceAll('\n', '\uFD3F ${i.numberInSurah} \uFD3E'))
                .join(' ')
            : allAyas.value = selectedSurah.value.ayahs //the rest of surahs
                .map((i) => i.text
                    .replaceAll('بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ', '')
                    .replaceAll('\n', '\uFD3F ${i.numberInSurah} \uFD3E'))
                .join(' ');
        _generateTextPages(); // Ensure pages are generated after fetching
      }
    } finally {
      isLoading(false);
    }
  }

  void _generateTextPages() {
    // Define the text style and page dimensions
    const TextStyle textStyle = TextStyle(fontSize: 18);
    final double pageHeight =
        Get.context!.size!.height; // Adjust based on AppBar or padding
    final double pageWidth = Get.context!.size!.width; // Adjust for padding
    final textSpan = TextSpan(text: allAyas.value, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
      maxLines: null,
    );
    textPainter.layout(maxWidth: pageWidth);
    String remainingText = allAyas.value;

    // Split the text into pages based on available height
    while (remainingText.isNotEmpty) {
      textPainter.text = TextSpan(text: remainingText, style: textStyle);
      textPainter.layout(
          maxWidth: pageWidth * 0.7); // Corrected to use actual max width
      // Get the maximum offset that fits within the available height
      final endPosition = textPainter
          .getPositionForOffset(Offset(0, pageHeight * 0.6))
          .offset; // Corrected to use actual max height
      // Ensure the endPosition does not exceed the remaining text length
      final end = endPosition.clamp(0, remainingText.length);
      final pageText = remainingText.substring(0, end).trim();
      // Add the page text to the list of pages
      surahPages.add(pageText);
      // Remove the part that has already been added to the page
      remainingText = remainingText.substring(end).trim();
    }
  }
}
