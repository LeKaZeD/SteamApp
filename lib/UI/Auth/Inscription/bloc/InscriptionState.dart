import 'package:steam_app/UI/Auth/FormSubmissionStatus.dart';

class InscriptionState {
  final bool errorSupa;
  final String erromsg;

  final String username;
  final bool isErrorIconUsername;

  bool get isValidUsername => email.length > 6;

  final String email;
  final bool isErrorIconEmail;

  bool get isValidEmail => email.length > 6 && email.contains('@');

  final String password;
  final bool isErrorIconPassword;

  bool get isValidPassword => password.length > 6;

  final String passwordConfirm;
  final bool isErrorIconPasswordConfirm;

  bool get isValidPasswordConfirm => passwordConfirm == password;

  final FormSubmissionStatus formStatus;

  InscriptionState({
    this.errorSupa = false,
    this.erromsg = "",
    this.email = "",
    this.username = "",
    this.password = "",
    this.passwordConfirm = "",
    this.formStatus = const InitialFormStatus(),
    this.isErrorIconUsername = false,
    this.isErrorIconEmail = false,
    this.isErrorIconPassword = false,
    this.isErrorIconPasswordConfirm = false,
  });

  InscriptionState copyWith(
      {String? username,
      String? email,
      String? password,
      String? passwordConfirm,
      String? erromsg,
      bool? errorSupa,
      FormSubmissionStatus? formStatus,
      bool? isErrorIconUsername,
      bool? isErrorIconEmail,
      bool? isErrorIconPassword,
      bool? isErrorIconPasswordConfirm}) {
    return InscriptionState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        erromsg: erromsg ?? this.erromsg,
        errorSupa: errorSupa ?? this.errorSupa,
        formStatus: formStatus ?? this.formStatus,
        isErrorIconEmail: isErrorIconEmail ?? this.isErrorIconEmail,
        isErrorIconUsername: isErrorIconUsername ?? this.isErrorIconUsername,
        isErrorIconPassword: isErrorIconPassword ?? this.isErrorIconPassword,
        isErrorIconPasswordConfirm:
            isErrorIconPasswordConfirm ?? this.isErrorIconPasswordConfirm);
  }
}
