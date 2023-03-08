import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/data/models/response/topgames.dart';
import 'package:steam_app/widget/Game_widget.dart';

import '../res/app_images.dart';
import '../res/app_vactorial_images.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.logged});

  final String? logged;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    void Like() {
      Navigator.of(context).pushNamed("/like");
    }

    void WhishList() {
      Navigator.of(context).pushNamed("/whishlist");
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Accueil"),
          backgroundColor: AppColors.background,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: Like,
                icon: SvgPicture.asset(AppVactorialImages.like)),
            IconButton(
                onPressed: WhishList,
                icon: SvgPicture.asset(AppVactorialImages.whishlist))
          ],
          //leading: Container(),
        ),
        body: ListView(
          children: <Widget>[
            Text("test"),
            Text("data"),
            Gamewidget(
                name: "test", editeur: "test", prix: "test", img: "nope"),
            FutureBuilder<List<topGame>>(
              future: RemoteAPISteam().getTopGame(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Gamewidget(
                            name: snapshot.data![index].rank.toString(),
                            editeur: "editeur",
                            prix: "prix",
                            img: "img");
                      });
                } else {
                  return Text("c'est complex gros");
                }
              },
            )
          ],
        ));
  }
}
