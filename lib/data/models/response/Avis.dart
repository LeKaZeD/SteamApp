import 'package:steam_app/domain/entities/avisEntity.dart';

class Avis {
  final String msg;
  final String appidclient;

  Avis({required this.msg, required this.appidclient});

  factory Avis.fromMap(Map<String, dynamic> map) {
    return Avis(
        msg: map['review'] ?? '', appidclient: map['author']['steamid'] ?? '');
  }

  avisEntity toEntity() {
    return avisEntity(msg: msg, appidclient: appidclient);
  }
}
