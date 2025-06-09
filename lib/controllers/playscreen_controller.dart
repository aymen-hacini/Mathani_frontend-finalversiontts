import 'dart:convert';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wird/data/models/surah.dart';
import 'package:http/http.dart' as http;

class PlayscreenController extends GetxController {
  var selectedSurah = Surah(
          number: 0,
          englishName: '',
          arabicName: '',
          ayahs: [],
          englishTranslation: '',
          revelationType: "")
      .obs;

  var audioUrl = ''.obs;
  var isLoading = true.obs;
  var isrepeating = false.obs;
  var selectedSurahNo = 1.obs;
  late AudioPlayer audioPlayer;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  @override
  void onInit() {
    audioPlayer = AudioPlayer();

    selectedSurahNo.value = Get.arguments["selectedSurahNo"];
    fetchSurahAyahs(selectedSurahNo.value);
    fetchAudioUrl(selectedSurahNo.value);

    audioPlayer.durationStream.listen((newDuration) {
      duration.value = newDuration ?? Duration.zero;
    });

    audioPlayer.positionStream.listen((newPosition) {
      position.value = newPosition;
    });

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
      }
    } finally {
      isLoading(false);
    }
  }

  void fastForwardToNextSurah() {
    selectedSurahNo.value += 1; // Increment the surah number
    fetchSurahAyahs(selectedSurahNo.value);
    fetchAudioUrl(selectedSurahNo.value); // Fetch the new surah audio
    playAudio(); // Play the new surah audio
  }

  void rewindSurah() {
    fetchAudioUrl(selectedSurahNo.value); // Fetch the current surah audio again
    playAudio(); // Play the surah audio from the start
  }

  void fetchAudioUrl(int surahNumber) async {
    try {
      isLoading(true);
      audioUrl.value =
          'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/$surahNumber.mp3';
      await audioPlayer.setUrl(audioUrl.value);
    } finally {
      isLoading(false);
    }
  }

  void playAudio() {
    audioPlayer.play();
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed &&
          isrepeating.value) {
        rewindSurah(); // If repeating, restart surah
      } else if (state.processingState == ProcessingState.completed &&
          !isrepeating.value) {
        audioPlayer.stop();
      }
    });

    audioPlayer.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {
        print('Error loading audio: $e');
        audioPlayer.stop();
      },
    );
  }

  void toggleRepeatMode() {
    isrepeating.value = !isrepeating.value;
    print('Repeat mode: ${isrepeating.value}');
  }

  void pauseRecitation() {
    audioPlayer.pause();
  }

  void seekAudio(Duration position) {
    audioPlayer.seek(position);
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
