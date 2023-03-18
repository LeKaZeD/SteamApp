import 'package:flutter/material.dart';
import 'package:steam_app/Screen/Connexion.dart';
import 'package:steam_app/Screen/DetailJeu.dart';
import 'package:steam_app/Screen/Likes.dart';
import 'package:steam_app/Screen/Search.dart';
import 'package:steam_app/Screen/Wishlist.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Screen/HomePage.dart';
import 'Screen/Inscription.dart';

/*void main() {
  runApp(const MyApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zlnujbmqmuejpvyuphcf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpsbnVqYm1xbXVlanB2eXVwaGNmIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg2NjAzMzQsImV4cCI6MTk5NDIzNjMzNH0.Q9UpBnOlMfdPOy7wQ4Ov2YA2aBf6FzgYCOTL3tYtgDk',
  );
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
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case "/login":
            return MaterialPageRoute(builder: (context) => Connexion());
          case "/inscription":
            return MaterialPageRoute(builder: (context) => Inscription());
          case "/whishlist":
            return MaterialPageRoute(
                builder: (context) => const WhishlistVide());
          case "/like":
            return MaterialPageRoute(
                builder: (context) => const LikesvidesWidget());
          case "/Search":
            return MaterialPageRoute(
                builder: (context) => Search(
                      controler: settings.arguments,
                    ));
          default:
            if (Supabase.instance.client.auth.currentSession != null) {
              return MaterialPageRoute(builder: (context) => MyHomePage());
            } else {
              return MaterialPageRoute(builder: (context) => Connexion());
            }
        }
      },
    );
  }
}
