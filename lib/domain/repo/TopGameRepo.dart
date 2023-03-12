import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/data/models/request/requestGameDescription.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

class TopGameRepo {
  TopGameRepo();

  Future<List<gameDescriptionQuestion>> getTopGame(
      int index, int nombre) async {
    final gametop = await RemoteAPISteam().getTopGame();
    final List<gameDescriptionQuestion> gameDescList = [];
    for (var element = index; element < index + nombre; element++) {
      final gameDesc = await RemoteAPISteam()
          .getGame(RequestGameDescription(appid: gametop[element].appid))
          .then((value) => {gameDescList.add(value.toEntity())});
    }

    return gameDescList;
  }
}
