import 'package:steam_app/data/repository/TopGameRepoImpl.dart';
import 'package:steam_app/domain/entities/topgame_question.dart';
import 'package:steam_app/domain/repository/TopGameRepo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final TopGameUseCaseProvider = Provider<TopGameUseCase>(
    (ref) => TopGameUseCase(ref.read(TopGameRepoProvider)));

class TopGameUseCase {
  TopGameUseCase(this._reprository);

  final TopGameRepo _reprository;

  Future<List<topGameQuestion>> getTopGame() {
    return _reprository.getTopGame();
  }
}
