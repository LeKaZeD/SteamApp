import 'package:flutter/material.dart';

import '../AppColors.dart';
import 'Component/Button.dart';
import 'Component/Input.dart';

class Inscription extends StatefulWidget {
  Inscription({super.key, required this.title});

  final String title;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  State<Inscription> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<Inscription> {
  void Inscription() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          width: 330,
          child: Form(
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
                MyTextField(
                    controler: widget.usernameController,
                    hintText: "Nom d'utilisateur",
                    obscureText: false),
                const SizedBox(height: 10),
                MyTextField(
                    controler: widget.emailController,
                    hintText: "E-mail",
                    obscureText: false),
                const SizedBox(height: 10),
                MyTextField(
                    controler: widget.passwordController,
                    hintText: "Mot de passe",
                    obscureText: true),
                const SizedBox(height: 10),
                MyTextField(
                    controler: widget.passwordConfirmController,
                    hintText: "Vérification du mot de passe",
                    obscureText: true),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 10,
                    maxHeight: 50,
                  ),
                ),
                Button(onTap: Inscription, name: "S’inscrire"),
              ],
            ),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
