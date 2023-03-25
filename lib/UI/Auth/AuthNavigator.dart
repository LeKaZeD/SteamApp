import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/UI/Auth/AuthCubit.dart';
import 'package:steam_app/UI/Auth/Connexion/view/Connexion.dart';
import 'package:steam_app/UI/Auth/Inscription/view/Inscription.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state == AuthState.login) MaterialPage(child: Connexion()),
          if (state == AuthState.signUp) MaterialPage(child: Inscription())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
