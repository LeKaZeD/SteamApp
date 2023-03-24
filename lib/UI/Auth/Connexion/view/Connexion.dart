import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steam_app/AppColors.dart';
import 'package:steam_app/UI/Auth/AuthCubit.dart';
import 'package:steam_app/UI/Auth/Connexion/bloc/ConnexionBlock.dart';
import 'package:steam_app/UI/Auth/Connexion/bloc/ConnexionEvent.dart';
import 'package:steam_app/UI/Auth/Connexion/bloc/ConnexionState.dart';
import 'package:steam_app/UI/Auth/FormSubmissionStatus.dart';
import 'package:steam_app/UI/Component/Button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Connexion extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnexionBloc>(
      create: (_) => ConnexionBloc(authCubit: context.read<AuthCubit>()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.background,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Bienvenue !',
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
                      'Veuillez vous connecter ou créer un nouveau compte pour utiliser l\'application',
                      style: TextStyle(
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: AppColors.white),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 20),
                LoginForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget LoginForm(BuildContext _) {
    return Form(
        key: _formKey,
        child: Column(children: [
          EmailField(),
          const SizedBox(height: 10),
          PasswordField(),
          BlocBuilder<ConnexionBloc, ConnexionState>(
              builder: (BuildContext context, ConnexionState state) {
            return state.errorSupa
                ? ErrorDisplay()
                : const SizedBox(height: 100);
          }),
          LoginButton(),
          const SizedBox(height: 10),
          Builder(builder: (context) {
            return ButtonGost(
                onTap: () => _.read<AuthCubit>().showSignUp(),
                name: "Créer un nouveau compte");
          })
        ]));
  }

  Widget PasswordField() {
    return BlocBuilder<ConnexionBloc, ConnexionState>(
        builder: (BuildContext context, ConnexionState state) {
      return TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(52),
        ],
        validator: (val) =>
            state.isValidPassword ? null : 'Mot de passe trop court',
        onChanged: (value) => context
            .read<ConnexionBloc>()
            .add(LoginPasswordChanged(password: value)),
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

  Widget EmailField() {
    return BlocBuilder<ConnexionBloc, ConnexionState>(
        builder: (BuildContext context, ConnexionState state) {
      return TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(52),
        ],
        validator: (val) => state.isValidEmail
            ? null
            : "L'email est trop petit ou ne contient pas @",
        onChanged: (value) =>
            context.read<ConnexionBloc>().add(LoginEmailChanged(email: value)),
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
          hintStyle: TextStyle(color: AppColors.placeholder),
        ),
        style: const TextStyle(color: AppColors.white),
      );
    });
  }

  Widget LoginButton() {
    return BlocBuilder<ConnexionBloc, ConnexionState>(
        builder: (BuildContext _, ConnexionState state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _.read<ConnexionBloc>().add(IconErreurEmailError());
                  _.read<ConnexionBloc>().add(IconErreurPasswordError());
                  _.read<ConnexionBloc>().add(ConnexionAppEvent());
                } else {
                  _.read<ConnexionBloc>().add(IconErreurEmailError());
                  _.read<ConnexionBloc>().add(IconErreurPasswordError());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "Se connecter",
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            );
    });
  }

  Widget ErrorDisplay() {
    return Row(children: [
      const SizedBox(height: 100),
      Expanded(child: BlocBuilder<ConnexionBloc, ConnexionState>(
          builder: (BuildContext context, ConnexionState state) {
        return Text(
          state.erromsg,
          style: const TextStyle(color: AppColors.error),
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
        );
      })),
      const SizedBox(height: 10)
    ]);
  }
}
