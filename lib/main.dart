import 'package:flutter/material.dart';
import 'package:steam_app/Screen/Connexion.dart';
import 'package:steam_app/Screen/LikesvidesWidget.dart';
import 'package:steam_app/Screen/WhishlistVide.dart';

import 'Screen/HomePage.dart';
import 'Screen/Inscription.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'GoogleSans',
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/home":
            return MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: 'App',
                    ));
          case "/login":
            return MaterialPageRoute(
                builder: (context) => Connexion(
                      title: 'login',
                    ));
          case "/inscription":
            return MaterialPageRoute(
                builder: (context) => Inscription(
                      title: 'inscription',
                    ));
          case "/whishlist":
          //return MaterialPageRoute(builder: (context) => whishlist());
            return MaterialPageRoute(
                builder: (context) => const WhishlistVide(
                  title: 'Ma liste de souhaits',
                ));

          case "/like":
            //return MaterialPageRoute(builder: (context) => const LikesvidesWidget());
            return MaterialPageRoute(
              builder: (context) => const LikesvidesWidget(
                title: 'Mes Likes',
              ));

          case "/help":
          //return MaterialPageRoute(builder: (context) => const Help());
          default:
            return MaterialPageRoute(
                builder: (context) => Connexion(
                      title: 'App',
                    ));
        }
      },
    );
  }
}
