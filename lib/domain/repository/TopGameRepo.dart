import 'package:steam_app/domain/entities/topgame_question.dart';

abstract class TopGameRepo {
  Future<List<topGameQuestion>> getTopGame();
}