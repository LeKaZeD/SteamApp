import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/ViewFlow/FlowCubit.dart';
import 'package:steam_app/UI/ViewFlow/Home/bloc/HomeEvent.dart';
import 'package:steam_app/UI/ViewFlow/Home/bloc/HomeState.dart';
import 'package:steam_app/domain/repo/TopGameRepo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FlowCubit flowCubit;

  HomeBloc({required this.flowCubit}) : super(HomeState()) {
    on<LoadMoreEvent>(onLoadMoreRunning);
    on<FirstLoadEvent>(onFirstLoadRunning);

    on<LikeNavigationEvent>(onLikeNavigation);
    on<WishNavigationEvent>(onWishNavigation);
  }

  FutureOr<void> onFirstLoadRunning(FirstLoadEvent event,
      Emitter<HomeState> emit) async {
    emit(state.copyWith(isFirstLoading: true));

    try {
      //call the first game
      final games = await TopGameRepo().getTopGame(0, 10);
      emit(state.copyWith(post: games));
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    emit(state.copyWith(isFirstLoading: false));
  }

  Future<FutureOr<void>> onLoadMoreRunning(LoadMoreEvent event,
      Emitter<HomeState> emit) async {
    if (state.hasNextPage == true &&
        state.isFirstLoadRunning == false &&
        state.isLoadMoreRunning == false &&
        state.controller.position.extentAfter < 300) {
      emit(state.copyWith(isLoadMoreRun: true));

      if (state.posts.length < 95) {
        // mettre une condition pour afficher plus avec une limite de 100
        final games = await TopGameRepo().getTopGame(state.posts.length, 5);

        final List list = state.posts;
        list.addAll(games);
        emit(state.copyWith(post: list));
      } else {
        emit(state.copyWith(hasNextPage: false));
      }
      emit(state.copyWith(isLoadMoreRun: false));
    }
  }

  FutureOr<void> onLikeNavigation(LikeNavigationEvent event,
      Emitter<HomeState> emit) {}

  FutureOr<void> onWishNavigation(WishNavigationEvent event,
      Emitter<HomeState> emit) {}
}
