import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/UI/Screen/DetailJeu.dart';
import 'package:steam_app/UI/widget/Game_widget.dart';
import 'package:steam_app/data/api/databaseService.dart';
import 'package:steam_app/res/app_vactorial_images.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WhishlistVide extends StatefulWidget {
  const WhishlistVide({super.key});

  @override
  _WhishlistVideState createState() => _WhishlistVideState();
}

class _WhishlistVideState extends State<WhishlistVide> {
  bool empty = true;
  bool loading = true;
  List _posts = [];

  void setlike() async {
    final res = await DatabaseService(Supabase.instance.client).getWishlist();
    if (res.isNotEmpty) {
      setState(() {
        empty = false;
        _posts = res;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    setlike();
    _controller = ScrollController();
    super.initState();
  }

  late ScrollController _controller = ScrollController();

  Widget emptyContainer = Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 250.0, right: 0.0, bottom: 50.0),
            child: SvgPicture.asset(AppVactorialImages.emptyWhishlist),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Vous n’avez encore pas liké de contenu.',
              style: TextStyle(
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            'Cliquez sur l’étoile pour en rajouter.',
            style: TextStyle(
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.normal,
                fontSize: 15,
                color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Ma liste de souhaits"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : empty
              ? emptyContainer
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SizedBox(
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
                                      game: _posts[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
