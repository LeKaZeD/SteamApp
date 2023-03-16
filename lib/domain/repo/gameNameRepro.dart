import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/data/models/request/requestGameDescription.dart';
import 'package:steam_app/data/models/request/requestGameName.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

class gameNameRepro {
  gameNameRepro();

  Future<List<gameDescriptionQuestion>> getGameByName(
      String nameGame, int index, int nombre) async {
    final api = RemoteAPISteam();
    final gameList = await api.getGamebyName(RequestGameName(name: nameGame));
    final gameDescList = <gameDescriptionQuestion>[];
    final length = gameList.length;
    final endIndex = index + nombre;

    if (length < endIndex) {
      nombre = length - index;
    }

    final requests = gameList.getRange(index, nombre).map((game) {
      return api
          .getGame(RequestGameDescription(appid: game.appid))
          .then((value) => gameDescList.add(value.toEntity()));
    });

    await Future.wait(requests);

    return gameDescList;
  }
}
