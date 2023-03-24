import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/UI/MyApp/bloc/SessionCubit.dart';
import 'package:steam_app/UI/MyApp/bloc/appNavigator.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'GoogleSans',
      ),
      /*onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/":
              return MaterialPageRoute(builder: (_) => MyHomePage());
            case "/login":
              return MaterialPageRoute(builder: (_) => Connexion());
            case "/inscription":
              return MaterialPageRoute(builder: (_) => Inscription());
            case "/whishlist":
              return MaterialPageRoute(builder: (_) => const WhishlistVide());
            case "/like":
              return MaterialPageRoute(
                  builder: (_) => const LikesvidesWidget());
            case "/Search":
              return MaterialPageRoute(
                  builder: (_) => Search(
                        controler: settings.arguments,
                      ));
            default:
              return null;
          }
        },*/
      home: BlocProvider(
        create: (context) => SessionsCubit(),
        child: AppNavigator(),
      ),
    );

    /*return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
    );*/
  }
}
