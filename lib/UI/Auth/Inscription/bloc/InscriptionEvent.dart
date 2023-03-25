abstract class InscriptionEvent {}

class SignUpEmailChanged extends InscriptionEvent {
  final String email;

  SignUpEmailChanged({required this.email});
}

class SignUpUsernameChanged extends InscriptionEvent {
  final String username;

  SignUpUsernameChanged({required this.username});
}

class SignUpPasswordChanged extends InscriptionEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}

class SignUpPasswordConfirmChanged extends InscriptionEvent {
  final String password;

  SignUpPasswordConfirmChanged({required this.password});
}

class IconErreurEmailError extends InscriptionEvent {}

class IconErreurUsernameError extends InscriptionEvent {}

class IconErreurPasswordError extends InscriptionEvent {}

class IconErreurPasswordConfirmError extends InscriptionEvent {}

class SignUpEvent extends InscriptionEvent {}
