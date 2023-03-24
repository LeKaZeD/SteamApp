import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

class DetailJeuState {
  final gameDescriptionQuestion game;

  final bool isLike;
  final bool isWish;
  final bool avis;
  final bool description;
  final bool loading;
  final List avisList;

  DetailJeuState(
      {required this.game,
      this.isLike = false,
      this.isWish = false,
      this.avis = false,
      this.description = true,
      this.loading = true,
      this.avisList = const []});

  DetailJeuState copyWith(
      {bool? isLike,
      bool? isWish,
      bool? avis,
      bool? description,
      bool? loading,
      List? avisList}) {
    return DetailJeuState(
        game: this.game,
        isLike: isLike ?? this.isLike,
        isWish: isWish ?? this.isWish,
        avis: avis ?? this.avis,
        description: description ?? this.description,
        loading: loading ?? this.loading,
        avisList: avisList ?? this.avisList);
  }
}
