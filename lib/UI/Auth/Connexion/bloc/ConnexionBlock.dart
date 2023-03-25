import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/Auth/AuthCubit.dart';
import 'package:steam_app/UI/Auth/Connexion/bloc/ConnexionEvent.dart';
import 'package:steam_app/UI/Auth/Connexion/bloc/ConnexionState.dart';
import 'package:steam_app/UI/Auth/FormSubmissionStatus.dart';
import 'package:steam_app/data/api/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  final AuthCubit authCubit;

  ConnexionBloc({required this.authCubit}) : super(ConnexionState()) {
    on<LoginEmailChanged>(onLoginEmailChanged);
    on<LoginPasswordChanged>(onLoginPasswordChanged);
    on<ConnexionAppEvent>(onConnectionApp);
    on<IconErreurEmailError>(onEmailError);
    on<IconErreurPasswordError>(onPasswordError);
  }

  FutureOr<void> onLoginEmailChanged(
      LoginEmailChanged event, Emitter<ConnexionState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<ConnexionState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<FutureOr<void>> onConnectionApp(
      ConnexionAppEvent event, Emitter<ConnexionState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      await AuthService(Supabase.instance.client)
          .signInUser(state.email, state.password);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
      authCubit.lauchSession();
    } on AuthException catch (e) {
      emit(state.copyWith(
          errorSupa: true,
          erromsg: "Combinaisons e-mail mot de passe incorrect",
          formStatus: SubmissionFailed(e)));
    }
  }

  FutureOr<void> onEmailError(
      IconErreurEmailError event, Emitter<ConnexionState> emit) {
    if (!state.isValidEmail) {
      emit(state.copyWith(isErrorIconEmail: true));
    } else {
      emit(state.copyWith(isErrorIconEmail: false));
    }
  }

  FutureOr<void> onPasswordError(
      IconErreurPasswordError event, Emitter<ConnexionState> emit) {
    if (!state.isValidPassword) {
      emit(state.copyWith(isErrorIconPassword: true));
    } else {
      emit(state.copyWith(isErrorIconPassword: false));
    }
  }
}
