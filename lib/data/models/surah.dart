class Surah {
  final int number;
  final String englishName;
  final String englishTranslation;
  final String arabicName;
  final String revelationType;
  final List<Ayah> ayahs;

  Surah(
      {required this.number,
      required this.englishName,
      required this.arabicName,
      required this.englishTranslation,
      required this.ayahs,required this.revelationType});

  factory Surah.fromJson(Map<String, dynamic> json) {
    List<Ayah> ayahs;
    if (json.containsKey('ayahs')) {
      var ayahsList = json['ayahs'] as List;
      ayahs = ayahsList.map((i) => Ayah.fromJson(i)).toList();
    } else {
      ayahs = [];
    }
    return Surah(
      number: json['number'],
      englishName: json['englishName'],
      arabicName: json['name'],
      englishTranslation: json['englishNameTranslation'],
      ayahs: ayahs,
      revelationType: json['revelationType']
    );
  }
}

class Ayah {
  final int numberInSurah;
   String text;
  String tafssir;

  Ayah({
    required this.numberInSurah,
    required this.text,
    required this.tafssir,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
        numberInSurah: json['numberInSurah'], text: json['text'], tafssir: "");
    
  }
}
