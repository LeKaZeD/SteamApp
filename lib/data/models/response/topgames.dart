import 'package:steam_app/domain/entities/topgame_question.dart';

class topGame {
  final int rank;
  final int appid;

  topGame({required this.rank, required this.appid});

  @override
  List<Object> get props => [rank, appid];

  factory topGame.fromMap(Map<String, dynamic> map) {
    return topGame(rank: map['rank'] ?? '', appid: map['appid'] ?? '');
  }

  topGameQuestion toEntity() {
    return topGameQuestion(rank: rank, appid: appid);
  }
}
