import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/Screen/Component/Input.dart';
import 'package:steam_app/Screen/DetailJeu.dart';
import 'package:steam_app/domain/repo/gameNameRepro.dart';
import 'package:steam_app/res/app_vactorial_images.dart';
import 'package:steam_app/widget/Game_widget.dart';

class Search extends StatefulWidget {
  final controler;

  const Search({super.key, required this.controler});

  @override
  State<StatefulWidget> createState() => _Search();
}

class _Search extends State<Search> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(AppVactorialImages.close)),
        title: const Text("Recherche"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      MyTextFieldResearch(
                          controler: widget.controler,
                          hintText: "Rechercher un jeu...",
                          obscureText: false,
                          formKey: _formKey,
                          action: () {
                            setState(() {
                              _isField = true;
                            });
                            _firstLoad();
                          }),
                      const SizedBox(height: 10),
                    ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 16),
                  child: Text("Nombre de résultats : ${_posts.length}",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 15,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
            _isField
                ? _isFirstLoadRunning
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Center(
                          child: SizedBox(
                              child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _posts.length,
                                  controller: _controller,
                                  itemBuilder: (_, index) => Gamewidget(
                                      game: _posts[index],
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailJeu(
                                                  title: "title",
                                                  game: _posts[index]),
                                            ));
                                      }),
                                ),
                              ),
                              if (_isLoadMoreRunning == true)
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 40),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              if (_hasNextPage == false) Container(),
                            ],
                          )),
                        ),
                      )
                : Container(
                    child: Text("nop"),
                  ),
          ],
        ),
      ),
    );
  }

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isField = false;

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

      if (_posts.length < 10) {
        // mettre une condition pour afficher plus avec une limite de 100
        final games = await gameNameRepro()
            .getGameByName(widget.controler.text, _posts.length, 5);
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
      final games =
          await gameNameRepro().getGameByName(widget.controler.text, 0, 100);
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
    if (widget.controler.text != null) {
      setState(() {
        _isField = true;
      });
    }
  }
}
