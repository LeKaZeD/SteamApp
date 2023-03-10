import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/Screen/Component/Input.dart';
import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/data/models/response/topgames.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';
import 'package:steam_app/domain/repo/TopGameRepo.dart';
import 'package:steam_app/widget/Game_widget.dart';

import '../res/app_images.dart';
import '../res/app_vactorial_images.dart';

import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, this.logged});

  final String? logged;
  final search = TextEditingController();

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
  void Like() {
    Navigator.of(context).pushNamed("/like");
  }

  void WhishList() {
    Navigator.of(context).pushNamed("/whishlist");
  }

  int _page = 0;

  final int _limit = 20;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  List _posts = [];

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      if (_posts.length < 95) {
        // mettre une condition pour afficher plus avec une limite de 100
        final games = await TopGameRepo().getTopGame(_posts.length);
        setState(() {
          _posts.addAll(games);
        });
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      //call the first game
      final games = await TopGameRepo().getTopGame(0);
      setState(() {
        _posts = games;
      });
    } catch (err) {
      print(err);
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller = ScrollController()
    ..addListener(_loadMore);

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
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
                onPressed: Like,
                icon: SvgPicture.asset(AppVactorialImages.like)),
            IconButton(
                onPressed: WhishList,
                icon: SvgPicture.asset(AppVactorialImages.whishlist))
          ],
          //leading: Container(),
        ),
        body: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Container(
                width: 380,
                child: Form(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        MyTextFieldResearch(
                            controler: widget.search,
                            hintText: "Rechercher un jeu...",
                            obscureText: false),
                        const SizedBox(height: 10),
                      ]),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                      width: 400,
                      child: _isFirstLoadRunning
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _posts.length,
                                    controller: _controller,
                                    itemBuilder: (_, index) => Gamewidget(
                                        name: _posts[index].name,
                                        editeur:
                                            _posts[index].publisher.isNotEmpty
                                                ? _posts[index].publisher[0]
                                                : "",
                                        prix: _posts[index].prix,
                                        img: _posts[index].imgURL),
                                  ),
                                ),
                                if (_isLoadMoreRunning == true)
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 40),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                if (_hasNextPage == false) Container(),
                              ],
                            )),
                ),
              ),
            ],
          ),
        ));
  }
}
