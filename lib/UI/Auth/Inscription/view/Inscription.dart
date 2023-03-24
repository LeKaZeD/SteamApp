import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steam_app/resources/AppColors.dart';
import 'package:steam_app/UI/Auth/AuthCubit.dart';
import 'package:steam_app/UI/Auth/FormSubmissionStatus.dart';
import 'package:steam_app/UI/Auth/Inscription/bloc/InscriptionBloc.dart';
import 'package:steam_app/UI/Auth/Inscription/bloc/InscriptionEvent.dart';
import 'package:steam_app/UI/Auth/Inscription/bloc/InscriptionState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/resources/resources.dart';

class Inscription extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InscriptionBloc>(
        create: (_) => InscriptionBloc(authCubit: context.read<AuthCubit>()),
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: AppColors.input,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        AppColors.background.withOpacity(1.0),
                        BlendMode.dstATop),
                    image: AssetImage(Images.bgPattern)),
              ),
            ),
            leading: IconButton(
                onPressed: () => context.read<AuthCubit>().showLogin(),
                icon: const Icon(Icons.arrow_back)),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: AppColors.background,
          body: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 0, right: 0),
            decoration: BoxDecoration(
              color: AppColors.input,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      AppColors.background.withOpacity(1.0), BlendMode.dstATop),
                  image: AssetImage(Images.bgPattern)),
            ),
            child: SizedBox(width: 330, child: FormSignUp()),
          ),
        ));
  }

  Widget FormSignUp() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Inscription',
            style: TextStyle(
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppColors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Flexible(
              flex: 1,
              child: Text(
                'Veuillez saisir ces différentes informations, afin que vos listes soient sauvegardées.',
                style: TextStyle(
                    fontFamily: 'Proxima',
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: AppColors.white),
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 20),
          usernameField(),
          const SizedBox(height: 10),
          EmailField(),
          const SizedBox(height: 10),
          PasswordField(),
          const SizedBox(height: 10),
          PasswordConfirmField(),
          BlocBuilder<InscriptionBloc, InscriptionState>(
              builder: (BuildContext context, InscriptionState state) {
            return state.errorSupa
                ? errorDisplay()
                : Container(
                    constraints: const BoxConstraints(
                      minHeight: 10,
                      maxHeight: 50,
                    ),
                  );
          }),
          SignUpButton()
        ],
      ),
    );
  }

  Widget SignUpButton() {
    return BlocBuilder<InscriptionBloc, InscriptionState>(
        builder: (BuildContext _, InscriptionState state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _.read<InscriptionBloc>().add(IconErreurEmailError());
                  _.read<InscriptionBloc>().add(IconErreurUsernameError());
                  _.read<InscriptionBloc>().add(IconErreurPasswordError());
                  _
                      .read<InscriptionBloc>()
                      .add(IconErreurPasswordConfirmError());
                  _.read<InscriptionBloc>().add(SignUpEvent());
                } else {
                  _.read<InscriptionBloc>().add(IconErreurEmailError());
                  _.read<InscriptionBloc>().add(IconErreurUsernameError());
                  _.read<InscriptionBloc>().add(IconErreurPasswordError());
                  _
                      .read<InscriptionBloc>()
                      .add(IconErreurPasswordConfirmError());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "S’inscrire",
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            );
    });
  }

  Widget PasswordField() {
    return BlocBuilder<InscriptionBloc, InscriptionState>(
        builder: (BuildContext context, InscriptionState state) {
      return TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(52),
        ],
        validator: (val) =>
            state.isValidPassword ? null : 'Mot de passe trop court',
        onChanged: (value) => context
            .read<InscriptionBloc>()
            .add(SignUpPasswordChanged(password: value)),
        obscureText: true,
        textAlign: TextAlign.center,
        cursorColor: AppColors.white,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: SizedBox(),
          ),
          suffixIcon: !state.isErrorIconPassword
              ? const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: SizedBox(),
                )
              : const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: Icon(Icons.error, color: AppColors.error),
                ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.input),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          fillColor: AppColors.input,
          filled: true,
          hintText: "Mot de passe",
          hintStyle: const TextStyle(color: AppColors.placeholder),
        ),
        style: const TextStyle(color: AppColors.white),
      );
    });
  }

  Widget PasswordConfirmField() {
    return BlocBuilder<InscriptionBloc, InscriptionState>(
        builder: (BuildContext context, InscriptionState state) {
      return TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(52),
        ],
        validator: (val) => state.isValidPasswordConfirm
            ? null
            : 'Le mot de passe ne correspond pas',
        onChanged: (value) => context
            .read<InscriptionBloc>()
            .add(SignUpPasswordConfirmChanged(password: value)),
        obscureText: true,
        textAlign: TextAlign.center,
        cursorColor: AppColors.white,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: SizedBox(),
          ),
          suffixIcon: !state.isErrorIconPasswordConfirm
              ? const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: SizedBox(),
                )
              : const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: Icon(Icons.error, color: AppColors.error),
                ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.input),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          fillColor: AppColors.input,
          filled: true,
          hintText: "Vérification du mot de passe",
          hintStyle: const TextStyle(color: AppColors.placeholder),
        ),
        style: const TextStyle(color: AppColors.white),
      );
    });
  }

  Widget EmailField() {
    return BlocBuilder<InscriptionBloc, InscriptionState>(
        builder: (BuildContext context, InscriptionState state) {
      return TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(52),
        ],
        validator: (val) => state.isValidEmail
            ? null
            : "L'email est trop petit ou ne contient pas @",
        onChanged: (value) => context
            .read<InscriptionBloc>()
            .add(SignUpEmailChanged(email: value)),
        obscureText: false,
        textAlign: TextAlign.center,
        cursorColor: AppColors.white,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: SizedBox(),
          ),
          suffixIcon: !state.isErrorIconEmail
              ? const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: SizedBox(),
                )
              : const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: Icon(Icons.error, color: AppColors.error),
                ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.input),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          fillColor: AppColors.input,
          filled: true,
          hintText: "E-mail",
          hintStyle: const TextStyle(color: AppColors.placeholder),
        ),
        style: const TextStyle(color: AppColors.white),
      );
    });
  }

  Widget usernameField() {
    return BlocBuilder<InscriptionBloc, InscriptionState>(
        builder: (BuildContext context, InscriptionState state) {
      return TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(52),
        ],
        validator: (val) => state.isValidUsername
            ? null
            : "Le nom d'utilisateur est trop court",
        onChanged: (value) => context
            .read<InscriptionBloc>()
            .add(SignUpUsernameChanged(username: value)),
        obscureText: false,
        textAlign: TextAlign.center,
        cursorColor: AppColors.white,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: SizedBox(),
          ),
          suffixIcon: !state.isErrorIconUsername
              ? const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: SizedBox(),
                )
              : const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: Icon(Icons.error, color: AppColors.error),
                ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.input),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error),
          ),
          fillColor: AppColors.input,
          filled: true,
          hintText: "Nom d'utilisateur",
          hintStyle: TextStyle(color: AppColors.placeholder),
        ),
        style: const TextStyle(color: AppColors.white),
      );
    });
  }

  Widget errorDisplay() {
    return BlocBuilder<InscriptionBloc, InscriptionState>(
        builder: (BuildContext context, InscriptionState state) {
      return Row(children: [
        const SizedBox(height: 100),
        Expanded(
          child: Text(
            state.erromsg,
            style: const TextStyle(color: AppColors.error),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10)
      ]);
    });
  }
}
