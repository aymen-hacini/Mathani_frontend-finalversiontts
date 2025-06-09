class Recitation {
  final String audioUrl;

  Recitation({required this.audioUrl});

  factory Recitation.fromJson(Map<String, dynamic> json) {
    return Recitation(
      audioUrl: json['audio'],
    );
  }
}
