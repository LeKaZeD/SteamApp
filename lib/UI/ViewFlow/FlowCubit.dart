import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/ViewFlow/FlowState.dart';

class FlowCubit extends Cubit<FlowState> {
  FlowCubit() : super(DefaultWay());

  void showHome() => emit(DefaultWay());

  void showLikeWay() => emit(LikeWay());

  void showWishlistWay() => emit(WishlistWay());
}
