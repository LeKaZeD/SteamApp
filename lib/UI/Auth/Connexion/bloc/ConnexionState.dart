import 'package:steam_app/UI/Auth/FormSubmissionStatus.dart';

class ConnexionState {
  final bool errorSupa;
  final String erromsg;

  final String email;
  final bool isErrorIconEmail;

  bool get isValidEmail => email.length > 6 && email.contains('@');

  final String password;
  final bool isErrorIconPassword;

  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  ConnexionState(
      {this.errorSupa = false,
      this.erromsg = "",
      this.email = "",
      this.password = "",
      this.formStatus = const InitialFormStatus(),
      this.isErrorIconEmail = false,
      this.isErrorIconPassword = false});

  ConnexionState copyWith(
      {String? email,
      String? password,
      String? erromsg,
      bool? errorSupa,
      FormSubmissionStatus? formStatus,
      bool? isErrorIconEmail,
      bool? isErrorIconPassword}) {
    return ConnexionState(
        email: email ?? this.email,
        password: password ?? this.password,
        erromsg: erromsg ?? this.erromsg,
        errorSupa: errorSupa ?? this.errorSupa,
        formStatus: formStatus ?? this.formStatus,
        isErrorIconEmail: isErrorIconEmail ?? this.isErrorIconEmail,
        isErrorIconPassword: isErrorIconPassword ?? this.isErrorIconPassword);
  }
}
