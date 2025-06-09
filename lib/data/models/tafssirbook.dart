class TafsirBook {
  final int id;
  final String name;

  TafsirBook({required this.id, required this.name});

  factory TafsirBook.fromJson(Map<String, dynamic> json) {
    return TafsirBook(
      id: json['id'],
      name: json['name'],
    );
  }
}
