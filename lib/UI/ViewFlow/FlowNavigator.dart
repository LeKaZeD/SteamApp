import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/ViewFlow/FlowCubit.dart';
import 'package:steam_app/UI/ViewFlow/FlowState.dart';
import 'package:steam_app/UI/ViewFlow/Home/view/HomePage.dart';
import 'package:steam_app/UI/ViewFlow/Likes/view/Likes.dart';
import 'package:steam_app/UI/ViewFlow/Wishlist/view/Wishlist.dart';

class FlowNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowCubit, FlowState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is DefaultWay) MaterialPage(child: MyHomePage()),
          if (state is LikeWay) MaterialPage(child: LikesvidesWidget()),
          if (state is WishlistWay) MaterialPage(child: Wishlist()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
