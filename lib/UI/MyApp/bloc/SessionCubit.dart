import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/MyApp/bloc/SessionState.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionsCubit extends Cubit<SessionState> {
  SessionsCubit() : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      if (await Supabase.instance.client.auth.currentSession == null) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated());
      }
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());

  void showSession() {
    emit(Authenticated());
  }

  void signOut() {
    emit(Unauthenticated());
  }
}
