import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/domain/entities/topgame_question.dart';
import 'package:steam_app/domain/repository/TopGameRepo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final TopGameRepoProvider = Provider<TopGameRepo>(
    (ref) => TopGameRepoImpl(ref.read(remoteApiProvider)));

class TopGameRepoImpl extends TopGameRepo {
  final RemoteAPISteam _remoteAPISteam;

  TopGameRepoImpl(this._remoteAPISteam);

  @override
  Future<List<topGameQuestion>> getTopGame() {
    return _remoteAPISteam
        .getTopGame()
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}
