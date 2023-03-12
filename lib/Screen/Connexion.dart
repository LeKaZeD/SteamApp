import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:steam_app/Screen/Component/Button.dart';
import 'package:steam_app/Screen/Component/Input.dart';

class Connexion extends StatefulWidget {
  Connexion({super.key, required this.title});

  final String title;
  final EmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<Connexion> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<Connexion> {
  void inscription() {
    Navigator.of(context).pushNamed("/inscription");
  }

  void login() {
    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          width: 330,
          child: Form(
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
                MyTextField(
                    controler: widget.EmailController,
                    hintText: "E-mail",
                    obscureText: false),
                const SizedBox(height: 10),
                MyTextField(
                    controler: widget.passwordController,
                    hintText: "Mot de passe",
                    obscureText: true),
                const SizedBox(height: 100),
                Button(onTap: login, name: "Se connecter"),
                const SizedBox(height: 10),
                ButtonGost(onTap: inscription, name: "Créer un nouveau compte")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
