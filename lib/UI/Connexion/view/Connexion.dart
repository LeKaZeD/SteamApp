import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:steam_app/UI/Component/Button.dart';
import 'package:steam_app/UI/Component/Input.dart';
import 'package:steam_app/UI/Connexion/bloc/ConnexionBlock.dart';
import 'package:steam_app/data/api/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Connexion extends StatelessWidget {
  const Connexion({super.key});

  @override
  Widget build(BuildContext context) {
    Widget errorDisplay = Row(children: [
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

    return BlocProvider<ConnexionBloc>(
      create: (_) => ConnexionBloc(),
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
                  BlocBuilder<ConnexionBloc, ConnexionState>(
                      builder: (BuildContext context, ConnexionState state) {
                    return MyTextField(
                      controler: state.EmailController,
                      hintText: "E-mail",
                      obscureText: false,
                      error: state.errorSupa,
                    );
                  }),
                  const SizedBox(height: 10),
                  BlocBuilder<ConnexionBloc, ConnexionState>(
                      builder: (BuildContext context, ConnexionState state) {
                    return MyTextField(
                        controler: state.passwordController,
                        hintText: "Mot de passe",
                        obscureText: true,
                        error: state.errorSupa);
                  }),
                  BlocBuilder<ConnexionBloc, ConnexionState>(
                      builder: (BuildContext context, ConnexionState state) {
                    return state.errorSupa
                        ? errorDisplay
                        : const SizedBox(height: 100);
                  }),
                  BlocBuilder<ConnexionBloc, ConnexionState>(
                      builder: (BuildContext context, ConnexionState state) {
                    return Button(
                        onTap: () {
                          BlocProvider.of<ConnexionBloc>(context)
                              .add(ConnexionAppEvent());
                          if (!state.errorSupa) {
                            Navigator.of(context).pushNamed("/home");
                          }
                        },
                        name: "Se connecter");
                  }),
                  const SizedBox(height: 10),
                  Builder(builder: (context) {
                    return ButtonGost(
                        onTap: () {
                          BlocProvider.of<ConnexionBloc>(context)
                              .add(InscriptionAppEvent());
                        },
                        name: "Créer un nouveau compte");
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
