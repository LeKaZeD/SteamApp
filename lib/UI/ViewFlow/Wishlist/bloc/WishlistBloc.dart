import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/ViewFlow/FlowCubit.dart';
import 'package:steam_app/UI/ViewFlow/Wishlist/bloc/WishlistEvent.dart';
import 'package:steam_app/UI/ViewFlow/Wishlist/bloc/WishlistState.dart';
import 'package:steam_app/data/api/databaseService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final FlowCubit flowCubit;

  WishlistBloc({required this.flowCubit}) : super(WishlistState()) {
    on<SetLikeEvent>(onSetLike);
  }

  Future<FutureOr<void>> onSetLike(
      SetLikeEvent event, Emitter<WishlistState> emit) async {
    final res = await DatabaseService(Supabase.instance.client).getWishlist();
    if (res.isNotEmpty) {
      emit(state.copyWith(empty: false, loading: false, posts: res));
    } else {
      emit(state.copyWith(loading: false));
    }
  }
}
