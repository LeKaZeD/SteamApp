import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: ((context, state) {
      return Navigator(
        pages: [],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      );
    }));
  }

}