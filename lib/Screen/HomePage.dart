import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              onPressed: null, icon: SvgPicture.asset(AppVactorialImages.like)),
          IconButton(
              onPressed: null,
              icon: SvgPicture.asset(AppVactorialImages.whishlist))
        ],
        //leading: Container(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SvgPicture.asset(AppVactorialImages.like),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: SvgPicture.asset(
          AppVactorialImages.emptyLikes,
          color: AppColors.white,
          semanticsLabel: 'ACME',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
