import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

class gameDescription {
  final String name;
  final int appid;
  final String description;
  final List<String> publisher;
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
        name: map['appid']['data']['name'] ?? '',
        appid: map['appid']['data']['steam_appid'] ?? '',
        description: map['appid']['data']['short_description'] ?? '',
        publisher: map['appid']['data']['publishers'] ?? '',
        is_free: map['appid']['data']['is_free'] ?? '',
        imgURL: map['appid']['data']['header_image'] ?? '',
        prix: map['appid']['data']['price_overview']['final_formatted'] ?? '');
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
