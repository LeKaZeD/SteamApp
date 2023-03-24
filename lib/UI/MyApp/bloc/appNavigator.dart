import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/Auth/AuthCubit.dart';
import 'package:steam_app/UI/Auth/AuthNavigator.dart';
import 'package:steam_app/UI/Home/view/HomePage.dart';
import 'package:steam_app/UI/MyApp/bloc/SessionCubit.dart';
import 'package:steam_app/UI/MyApp/bloc/SessionState.dart';
import 'package:steam_app/UI/MyApp/view/loadingView.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionsCubit, SessionState>(builder: ((context, state) {
      return Navigator(
        pages: [
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionsCubit>()),
                child: AuthNavigator(),
              ),
            ),
          if (state is Authenticated) MaterialPage(child: MyHomePage()),
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      );
    }));
  }
}
