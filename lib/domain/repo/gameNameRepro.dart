import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/data/models/request/requestGameDescription.dart';
import 'package:steam_app/data/models/request/requestGameName.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

class gameNameRepro {
  gameNameRepro();

  Future<List<gameDescriptionQuestion>> getGameByName(
      String nameGame, int index, int nombre) async {
    final gameList =
        await RemoteAPISteam().getGamebyName(RequestGameName(name: nameGame));
    final List<gameDescriptionQuestion> gameDescList = [];
    if (gameList.length < index + nombre) {
      nombre = gameList.length - index;
    }
    for (var element = index; element < index + nombre; element++) {
      final gameDesc = await RemoteAPISteam()
          .getGame(RequestGameDescription(appid: gameList[element].appid))
          .then((value) => {gameDescList.add(value.toEntity())});
    }

    return gameDescList;
  }
}
