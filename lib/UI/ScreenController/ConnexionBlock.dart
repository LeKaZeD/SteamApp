import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/data/api/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ConnexionEvent {}

class ConnexionAppEvent extends ConnexionEvent {}

class InscriptionAppEvent extends ConnexionEvent {}

class ConnexionState {
  final bool errorSupa;
  final String erromsg;
  final EmailController = TextEditingController();
  final passwordController = TextEditingController();

  ConnexionState(this.errorSupa, this.erromsg);
}

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  ConnexionBloc() : super(ConnexionState(false, "")) {
    on<ConnexionAppEvent>(login);
    on<InscriptionAppEvent>(inscription);
  }

  Future<void> login(event, emit) async {
    try {
      final res = await AuthService(Supabase.instance.client).signInUser(
          state.EmailController.text, state.passwordController.text);
      if (res.session != null) {
        //Navigator.of(context).pushNamed("/home");
        //Navigator.pushNamed(event.context, "home");
      }
    } on AuthException catch (e) {
      emit(ConnexionState(true, e.message));
    }
  }

  void inscription(event, emit) {
    emit(ConnexionState(false, ""));
    //Navigator.of(context).pushNamed("/inscription");
  }
}
