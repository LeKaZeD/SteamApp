import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/bloc/DetailJeuEvent.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/bloc/DetailJeuState.dart';
import 'package:steam_app/data/api/databaseService.dart';
import 'package:steam_app/domain/repo/AvisRepro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailJeuBloc extends Bloc<DetailJeuEvent, DetailJeuState> {
  final games;

  DetailJeuBloc({required this.games}) : super(DetailJeuState(game: games)) {
    on<ShowAvis>(onShowAvis);
    on<ShowDescription>(onShowDescription);

    on<LikeEvent>(onLike);
    on<WishEvent>(onWish);

    on<IsLikeEvent>(isLike);
    on<IsWishEvent>(isWish);
  }

  Future<FutureOr<void>> onShowAvis(
      ShowAvis event, Emitter<DetailJeuState> emit) async {
    emit(state.copyWith(avis: true, description: false));
    final res = await AvisRepro().getAvisGame(state.game.appid, 40);
    emit(state.copyWith(avisList: res, loading: false));
  }

  FutureOr<void> onShowDescription(
      ShowDescription event, Emitter<DetailJeuState> emit) {
    emit(state.copyWith(avis: false, description: true, loading: true));
  }

  FutureOr<void> onLike(LikeEvent event, Emitter<DetailJeuState> emit) {
    if (state.isLike) {
      DatabaseService(Supabase.instance.client).deletelike(state.game.appid);
      emit(state.copyWith(isLike: false));
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} enlevé des likes")));*/
    } else {
      DatabaseService(Supabase.instance.client).addlike(state.game.appid);
      emit(state.copyWith(isLike: true));
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} ajouté au like")));*/
    }
  }

  FutureOr<void> onWish(WishEvent event, Emitter<DetailJeuState> emit) {
    if (state.isWish) {
      DatabaseService(Supabase.instance.client)
          .deleteWishlist(state.game.appid);
      emit(state.copyWith(isWish: false));
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} enlevé de la Wishlist")));*/
    } else {
      DatabaseService(Supabase.instance.client).addWishlist(state.game.appid);
      emit(state.copyWith(isWish: true));
      /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} ajouté de la Wishlist")));*/
    }
  }

  Future<FutureOr<void>> isLike(
      IsLikeEvent event, Emitter<DetailJeuState> emit) async {
    final bool res = await DatabaseService(Supabase.instance.client)
        .islike(state.game.appid);
    emit(state.copyWith(isLike: res));
  }

  Future<FutureOr<void>> isWish(
      IsWishEvent event, Emitter<DetailJeuState> emit) async {
    final bool res = await DatabaseService(Supabase.instance.client)
        .isWishlist(state.game.appid);
    emit(state.copyWith(isWish: res));
  }
}
