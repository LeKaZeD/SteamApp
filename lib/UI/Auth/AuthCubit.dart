import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/MyApp/bloc/SessionCubit.dart';

enum AuthState { login, signUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionsCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  void showLogin() => emit(AuthState.login);

  void showSignUp() => emit(AuthState.signUp);

  void lauchSession() => sessionCubit.showSession();
}
