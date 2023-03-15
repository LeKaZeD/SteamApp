import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/data/models/request/requestGameDescription.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

class TopGameRepo {
  TopGameRepo();

  Future<List<gameDescriptionQuestion>> getTopGame(
      int index, int nombre) async {
    final gametop = await RemoteAPISteam().getTopGame();
    final api = RemoteAPISteam();
    final List<gameDescriptionQuestion> gameDescList = [];

    final endIndex = index + nombre;
    final requests = gametop.sublist(index, endIndex).map((game) {
      return api
          .getGame(RequestGameDescription(appid: game.appid))
          .then((value) => gameDescList.add(value.toEntity()));
    });

    await Future.wait(requests);

    return gameDescList;
  }
}
