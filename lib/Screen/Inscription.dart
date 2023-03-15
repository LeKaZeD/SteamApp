import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:steam_app/Screen/Component/Button.dart';
import 'package:steam_app/Screen/Component/Input.dart';
import 'package:steam_app/data/api/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  bool username = false;
  bool email = false;
  bool pass = false;
  String msgError = '';

  void Inscription() async {
    setState(() {
      email = false;
      pass = false;
      username = false;
    });
    if (widget.usernameController.text.length < 5) {
      setState(() {
        username = true;
        msgError = "Le nom d'utilisateur doit contenir au moin 5 lettre";
      });
    }
    if (!widget.emailController.text.contains("@") &&
        widget.emailController.text.length < 10) {
      setState(() {
        email = true;
        msgError = "L'email doit contenir au moin un @ et 10 carractère";
      });
    }
    if (widget.passwordController.text !=
        widget.passwordConfirmController.text) {
      setState(() {
        pass = true;
        msgError = "Les mots de passe ne sont pas pareil";
      });
    }
    if (!username && !email && !pass) {
      try {
        final res = await AuthService(Supabase.instance.client).signUp(
            widget.emailController.text,
            widget.passwordController.text,
            widget.usernameController.text);
        if (res.session != null) {
          Navigator.of(context).pushNamed("/home");
        }
      } on AuthException catch (e) {
        setState(() {
          msgError = e.message;
        });
      }
    } else {}
  }

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
                  obscureText: false,
                  error: username,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controler: widget.emailController,
                  hintText: "E-mail",
                  obscureText: false,
                  error: email,
                ),
                const SizedBox(height: 10),
                MyTextField(
                    controler: widget.passwordController,
                    hintText: "Mot de passe",
                    obscureText: true,
                    error: pass),
                const SizedBox(height: 10),
                MyTextField(
                  controler: widget.passwordConfirmController,
                  hintText: "Vérification du mot de passe",
                  obscureText: true,
                  error: pass,
                ),
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
