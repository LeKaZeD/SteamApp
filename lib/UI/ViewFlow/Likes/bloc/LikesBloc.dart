import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/ViewFlow/FlowCubit.dart';
import 'package:steam_app/UI/ViewFlow/Likes/bloc/LikesEvent.dart';
import 'package:steam_app/UI/ViewFlow/Likes/bloc/LikesState.dart';
import 'package:steam_app/data/api/databaseService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  final FlowCubit flowCubit;

  LikesBloc({required this.flowCubit}) : super(LikesState()) {
    on<SetLikeEvent>(onSetLike);
  }

  Future<FutureOr<void>> onSetLike(
      SetLikeEvent event, Emitter<LikesState> emit) async {
    final res = await DatabaseService(Supabase.instance.client).getLike();
    if (res.isNotEmpty) {
      emit(state.copyWith(empty: false, loading: false, posts: res));
    } else {
      emit(state.copyWith(loading: false));
    }
  }
}
