import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

class gameDescription {
  final String name;
  final int appid;
  final String description;
  final List<dynamic> publisher;
  final bool is_free;
  final String imgURL;
  final String prix;

  gameDescription(
      {required this.name,
      required this.appid,
      required this.description,
      required this.publisher,
      required this.is_free,
      required this.imgURL,
      required this.prix});

  factory gameDescription.fromMap(Map<String, dynamic> map) {
    return gameDescription(
        name: map['name'] ?? '',
        appid: map['steam_appid'] ?? 0,
        description: map['short_description'] ?? '',
        publisher: map['publishers'] ?? '',
        is_free: map['is_free'] ?? false,
        imgURL: map['header_image'] ?? '',
        prix: map['is_free'] == true
            ? map['price_overview']['final_formatted']
            : "free");
  }

  gameDescriptionQuestion toEntity() {
    return gameDescriptionQuestion(
        name: name,
        appid: appid,
        description: description,
        publisher: publisher,
        is_free: is_free,
        imgURL: imgURL,
        prix: prix);
  }
}
