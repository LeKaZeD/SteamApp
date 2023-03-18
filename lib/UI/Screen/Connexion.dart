import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:steam_app/UI/Component/Button.dart';
import 'package:steam_app/UI/Component/Input.dart';
import 'package:steam_app/data/api/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Connexion extends StatefulWidget {
  Connexion({super.key});

  final EmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<Connexion> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<Connexion> {
  void inscription() {
    setState(() {
      errorSupa = false;
    });
    Navigator.of(context).pushNamed("/inscription");
  }

  bool errorSupa = false;
  String erromsg = '';

  void login() async {
    try {
      final res = await AuthService(Supabase.instance.client).signInUser(
          widget.EmailController.text, widget.passwordController.text);
      if (res.session != null) {
        Navigator.of(context).pushNamed("/home");
      }
    } on AuthException catch (e) {
      setState(() {
        errorSupa = true;
        erromsg = e.message;
      });
    }
  }

  @override
  void dispose() {
    errorSupa;
    erromsg;
    super.dispose();
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget errorDisplay = Row(children: [
      const SizedBox(height: 100),
      Expanded(
        child: Text(
          erromsg,
          style: const TextStyle(color: AppColors.error),
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 10)
    ]);

    return Scaffold(
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
                  obscureText: false,
                  error: errorSupa,
                ),
                const SizedBox(height: 10),
                MyTextField(
                    controler: widget.passwordController,
                    hintText: "Mot de passe",
                    obscureText: true,
                    error: errorSupa),
                errorSupa ? errorDisplay : const SizedBox(height: 100),
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
