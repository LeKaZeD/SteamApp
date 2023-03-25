import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/Auth/AuthCubit.dart';
import 'package:steam_app/UI/Auth/FormSubmissionStatus.dart';
import 'package:steam_app/UI/Auth/Inscription/bloc/InscriptionEvent.dart';
import 'package:steam_app/UI/Auth/Inscription/bloc/InscriptionState.dart';
import 'package:steam_app/data/api/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final AuthCubit authCubit;

  InscriptionBloc({required this.authCubit}) : super(InscriptionState()) {
    on<SignUpEmailChanged>(onSignUpEmailChanged);
    on<SignUpUsernameChanged>(onSignUpUsernameChanged);
    on<SignUpPasswordChanged>(onSignUpPasswordChanged);
    on<SignUpPasswordConfirmChanged>(onSignUpPasswordConfirmChanged);

    on<IconErreurEmailError>(onEmailError);
    on<IconErreurUsernameError>(onUsernameError);
    on<IconErreurPasswordError>(onPasswordError);
    on<IconErreurPasswordConfirmError>(onPasswordConfirmError);

    on<SignUpEvent>(onSignUpSubmit);
  }

  FutureOr<void> onSignUpEmailChanged(
      SignUpEmailChanged event, Emitter<InscriptionState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> onSignUpUsernameChanged(
      SignUpUsernameChanged event, Emitter<InscriptionState> emit) {
    emit(state.copyWith(email: event.username));
  }

  FutureOr<void> onSignUpPasswordChanged(
      SignUpPasswordChanged event, Emitter<InscriptionState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> onSignUpPasswordConfirmChanged(
      SignUpPasswordConfirmChanged event, Emitter<InscriptionState> emit) {
    emit(state.copyWith(passwordConfirm: event.password));
  }

  Future<FutureOr<void>> onSignUpSubmit(
      SignUpEvent event, Emitter<InscriptionState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      await AuthService(Supabase.instance.client)
          .signUp(state.email, state.password, state.username);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
      authCubit.lauchSession();
    } on AuthException catch (e) {
      emit(state.copyWith(
          errorSupa: true,
          erromsg: e.message,
          formStatus: SubmissionFailed(e)));
    }
  }

  FutureOr<void> onEmailError(
      IconErreurEmailError event, Emitter<InscriptionState> emit) {
    if (!state.isValidEmail) {
      emit(state.copyWith(isErrorIconEmail: true));
    } else {
      emit(state.copyWith(isErrorIconEmail: false));
    }
  }

  FutureOr<void> onUsernameError(
      IconErreurUsernameError event, Emitter<InscriptionState> emit) {
    if (!state.isValidUsername) {
      emit(state.copyWith(isErrorIconUsername: true));
    } else {
      emit(state.copyWith(isErrorIconUsername: false));
    }
  }

  FutureOr<void> onPasswordError(
      IconErreurPasswordError event, Emitter<InscriptionState> emit) {
    if (!state.isValidPassword) {
      emit(state.copyWith(isErrorIconPassword: true));
    } else {
      emit(state.copyWith(isErrorIconPassword: false));
    }
  }

  FutureOr<void> onPasswordConfirmError(
      IconErreurPasswordConfirmError event, Emitter<InscriptionState> emit) {
    if (!state.isValidPasswordConfirm) {
      emit(state.copyWith(isErrorIconPasswordConfirm: true));
    } else {
      emit(state.copyWith(isErrorIconPasswordConfirm: false));
    }
  }
}
