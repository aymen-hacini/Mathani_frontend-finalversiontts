import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wird/data/models/Surah.dart';
import 'package:http/http.dart' as http;

class QuranscreenController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  var surahs = <Surah>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    fetchSurahs();

    super.onInit();
  }

  void fetchSurahs() async {
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var surahList = jsonResponse['data'] as List;
        surahs.value = surahList.map((e) => Surah.fromJson(e)).toList();
      }
    } finally {
      isLoading(false);
    }
  }
}
