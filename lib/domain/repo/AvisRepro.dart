import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/domain/entities/avisEntity.dart';

class AvisRepro {
  AvisRepro();

  Future<List<avisEntity>> getAvisGame(int gameID, int nombre) async {
    final api = RemoteAPISteam();
    final avis = await api.getAvis(gameID);
    final topAvis = List.generate(
      nombre < avis.length ? nombre : avis.length,
      (i) => avis[i].toEntity(),
    );
    return topAvis;
  }
}
