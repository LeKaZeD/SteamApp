abstract class ConnexionEvent {}

class LoginEmailChanged extends ConnexionEvent {
  final String email;

  LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends ConnexionEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class IconErreurEmailError extends ConnexionEvent {}

class IconErreurPasswordError extends ConnexionEvent {}

class ConnexionAppEvent extends ConnexionEvent {}

class InscriptionAppEvent extends ConnexionEvent {}
