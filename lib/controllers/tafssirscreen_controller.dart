import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wird/data/models/surah.dart';
import 'package:wird/data/models/tafssirbook.dart';

class TafssirscreenController extends GetxController {
  var tafsirBooks = <TafsirBook>[].obs;
  var selectedTafsirBook = TafsirBook(id: 1, name: 'Default').obs;

  var selectedSurah = Surah(
          number: 0,
          englishName: '',
          arabicName: '',
          ayahs: [],
          englishTranslation: '',
          revelationType: "")
      .obs;

  var isLoading = true.obs;
  // late int selectedSurahNo;

  @override
  void onInit() {
    fetchTafsirBooks();

    int selectedSurahNo = Get.arguments["selectedSurahNo"];
    fetchSurahAyahs(selectedSurahNo);

    super.onInit();
  }

  void fetchTafsirBooks() async {
    try {
      var response = await http
          .get(Uri.parse('http://api.quran-tafseer.com/tafseer/'), headers: {
        "Accept": "application/json; charset=UTF-8"
      } // Adding UTF-8 encoding
              );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List;
        tafsirBooks.value =
            jsonResponse.map((e) => TafsirBook.fromJson(e)).toList();
      }
    } catch (e) {
      print('Failed to load tafsir books: $e');
    }
  }

  void fetchSurahAyahs(int surahNumber) async {
    try {
      isLoading(true);
      var response = await http.get(
          Uri.parse('http://api.alquran.cloud/v1/surah/$surahNumber'),
          headers: {"Accept": "application/json; charset=UTF-8"});
      if (response.statusCode == 200) {
        var jsonResponse = json
            .decode(utf8.decode(response.bodyBytes)); // Decoding the response
        selectedSurah(Surah.fromJson(jsonResponse['data']));
        await fetchTafsirForAyahs(surahNumber);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTafsirForAyahs(int surahNumber) async {
    for (var ayah in selectedSurah.value.ayahs) {
      var tafsirResponse = await http.get(
          Uri.parse(
              'http://api.quran-tafseer.com/tafseer/${selectedTafsirBook.value.id}/$surahNumber/${ayah.numberInSurah}'),
          headers: {"Accept": "application/json; charset=UTF-8"});
      if (tafsirResponse.statusCode == 200) {
        var tafsirJson = json.decode(
            utf8.decode(tafsirResponse.bodyBytes)); // Decoding the response
        print(tafsirJson);
        ayah.tafssir = tafsirJson['text'];
      }
    }
    selectedSurah.refresh(); // Update the observable
  }

  void refreshTafsir(int surahNumber) {
    fetchTafsirForAyahs(surahNumber);
  }
}
