import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/ViewFlow/Search/bloc/SearchEvent.dart';
import 'package:steam_app/UI/ViewFlow/Search/bloc/SearchState.dart';
import 'package:steam_app/domain/repo/gameNameRepro.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchController;

  SearchBloc({required this.SearchController})
      : super(SearchState(search: SearchController)) {
    on<LoadMoreEvent>(onLoadMoreRunning);
    on<FirstLoadEvent>(onFirstLoadRunning);
    on<IsFieldNotEmpty>(onFieldEmptyCheck);
  }

  FutureOr<void> onFirstLoadRunning(
      FirstLoadEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(isFirstLoading: true));
    try {
      //call the first game
      final games =
          await gameNameRepro().getGameByName(state.search.text, 0, 100);
      emit(state.copyWith(post: games));
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    emit(state.copyWith(isFirstLoading: false));
  }

  Future<FutureOr<void>> onLoadMoreRunning(
      LoadMoreEvent event, Emitter<SearchState> emit) async {
    if (state.hasNextPage == true &&
        state.isFirstLoadRunning == false &&
        state.isLoadMoreRunning == false &&
        state.controller.position.extentAfter < 300) {
      emit(state.copyWith(isLoadMoreRun: true));

      if (state.posts.length < 10) {
        // mettre une condition pour afficher plus avec une limite de 100
        final games = await gameNameRepro()
            .getGameByName(state.search.text, state.posts.length, 5);
        final List list = state.posts;
        list.addAll(games);
        emit(state.copyWith(post: list));
      } else {
        emit(state.copyWith(hasNextPage: false));
      }

      emit(state.copyWith(isLoadMoreRun: false));
    }
  }

  FutureOr<void> onFieldEmptyCheck(
      IsFieldNotEmpty event, Emitter<SearchState> emit) {
    if (state.search.text != null) {
      emit(state.copyWith(isField: true));
    } else {
      emit(state.copyWith(isField: false));
    }
  }
}
