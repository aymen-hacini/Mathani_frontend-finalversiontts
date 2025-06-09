import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:wird/data/models/surah.dart';

class LearnscreenController extends GetxController {
  var ayahs = <Ayah>[].obs;
  var isLoading = true.obs;
  var recognizedWords = ''.obs;
  var currentWords = <String>[].obs;
  var currentAyahIndex = 0.obs;
  var currentWordIndex = 0.obs;

  late stt.SpeechToText speech;

  @override
  void onInit() {
    super.onInit();
    int selectedSurahNo = Get.arguments['selectedSurahNo'];
    fetchAyahs(selectedSurahNo);
    speech = stt.SpeechToText();
  }

  void fetchAyahs(int surahNo) async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse('http://api.alquran.cloud/v1/surah/$surahNo'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var ayahList = jsonResponse['data']['ayahs'] as List;
        ayahs.value = ayahList.map((e) => Ayah.fromJson(e)).toList();
        // Remove Arabic diacritics from ayah text
        for (var ayah in ayahs) {
          ayah.text = removeDiacritics(ayah.text);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  String removeDiacritics(String text) {
    final RegExp diacritics = RegExp(
        r'[\u0610-\u061A\u064B-\u065F\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]');
    return text.replaceAll(diacritics, '');
  }

  void startListening() async {
    if (!speech.isAvailable) {
      await speech.initialize();
    }

    if (speech.isAvailable) {
      speech.listen(
        onResult: (result) {
          print(result.recognizedWords);
          recognizedWords.value = result.recognizedWords;
          checkWordMatch(result.recognizedWords);
        },
        localeId: 'ar-SA', // Setting the locale to Arabic (Saudi Arabia)
      );
    }
  }

  void stopListening() {
    speech.stop();
  }

  void checkWordMatch(String spokenText) {
    final spokenWords = spokenText.split(' ');
    for (var spokenWord in spokenWords) {
      if (currentAyahIndex.value < ayahs.length) {
        print(ayahs[currentAyahIndex.value].text);
        final ayahWords = ayahs[currentAyahIndex.value].text.split(' ');
        print(ayahWords);

        if (currentWordIndex.value < ayahWords.length &&
            ayahWords[currentWordIndex.value] == spokenWord) {
          currentWords.add(spokenWord);
          currentWordIndex.value++;
          if (currentWordIndex.value == ayahWords.length) {
            currentAyahIndex.value++;
            currentWordIndex.value = 0;
          }
        } else {
          currentWords.clear();
          currentWordIndex.value = 0;
          break;
        }
      }
    }
  }
}
