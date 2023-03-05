import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:steam_app/Screen/HomePage.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key, required this.title});

  final String title;

  @override
  State<Connexion> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Bienvenue !',
                  style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: AppColors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Flexible(
                    flex: 1,
                    child: Text(
                      'Veuillez vous connecter ou créer un nouveau compte pour utiliser l\'application',
                      style: TextStyle(
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: AppColors.white),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle:
                          const TextStyle(fontFamily: 'Proxima', fontSize: 15)),
                  onPressed: () {},
                  child: const Text('Se connecter'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle:
                          const TextStyle(fontFamily: 'Proxima', fontSize: 15)),
                  onPressed: () {},
                  child: const Text('Créer un nouveau compte'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
