import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/Screen/Component/Input.dart';
import 'package:steam_app/Screen/DetailJeu.dart';
import 'package:steam_app/data/api/AuthService.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';
import 'package:steam_app/domain/repo/TopGameRepo.dart';
import 'package:steam_app/res/app_vactorial_images.dart';
import 'package:steam_app/widget/Game_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  final search = TextEditingController();


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

  void gameDescription(gameDescriptionQuestion game) {
    Navigator.of(context).pushNamed("/Detail", arguments: game);
  }

  void logout() {
    AuthService(Supabase.instance.client).signOut();
    Navigator.of(context).pushNamed("login");
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
        final games = await TopGameRepo().getTopGame(_posts.length, 5);
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
      final games = await TopGameRepo().getTopGame(0, 10);
      setState(() {
        _posts.addAll(games);
      });
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
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
    _controller = ScrollController()
      ..addListener(_loadMore);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Widget frontitem = SizedBox(
      height: 250,
      child: _isFirstLoadRunning
          ? Container()
          : Card(
        color: AppColors.input,
        margin: const EdgeInsets.all(0),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.input,
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: NetworkImage(_posts[0].imgURL),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_posts[0].name,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 19)),
                      const SizedBox(
                        height: 8,
                      ),
                      Flexible(
                        child: Text(
                          _posts[0].description,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailJeu(game: _posts[0]),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              child: Column(
                                children: [
                                  Text(
                                    "En savoir plus",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: AppColors.placeholder)),
                    child: Image.network(
                      _posts[0].imgURL,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 120,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );

    Widget meilleurVente = const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text("Les meilleurs ventes",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  decoration: TextDecoration.underline)),
        ),
      ],
    );

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
                icon: SvgPicture.asset(AppVactorialImages.whishlist)),
            IconButton(
                onPressed: logout, icon: const Icon(Icons.logout_outlined))
          ],
          //leading: Container(),
        ),
        body: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        MyTextFieldResearch(
                            controler: widget.search,
                            hintText: "Rechercher un jeu...",
                            obscureText: false,
                            formKey: _formKey,
                            action: () {
                              Navigator.of(context).pushNamed("/Search",
                                  arguments: widget.search);
                            }),
                        const SizedBox(height: 10),
                      ]),
                ),
              ),
              if (_isFirstLoadRunning)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: _posts.length,
                                        controller: _controller,
                                        itemBuilder: (_, index) {
                                          return index == 0
                                              ? Column(
                                            children: [
                                              frontitem,
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              meilleurVente,
                                            ],
                                          )
                                              : Gamewidget(
                                              game: _posts[index],
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailJeu(
                                                              game: _posts[
                                                              index]),
                                                    ));
                                              });
                                        }),
                                  ),
                                  if (_isLoadMoreRunning == true)
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 40),
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
                )
            ],
          ),
        ));
  }
}
