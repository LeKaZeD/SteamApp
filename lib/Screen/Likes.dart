import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/Screen/DetailJeu.dart';
import 'package:steam_app/data/api/databaseService.dart';
import 'package:steam_app/res/app_vactorial_images.dart';
import 'package:steam_app/widget/Game_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LikesvidesWidget extends StatefulWidget {
  const LikesvidesWidget({super.key, required this.title});

  final String title;

  @override
  _LikesvidesWidgetState createState() => _LikesvidesWidgetState();
}

class _LikesvidesWidgetState extends State<LikesvidesWidget> {
  bool empty = true;
  bool loading = true;
  List _posts = [];

  void setlike() async {
    final res = await DatabaseService(Supabase.instance.client).getLike();
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

  @override
  Widget build(BuildContext context) {
    Widget emptyContainer = Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 250.0, right: 0.0, bottom: 50.0),
              child: SvgPicture.asset(AppVactorialImages.emptyLikes),
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
              'Cliquez sur le coeur pour en rajouter.',
              style: TextStyle(
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Mes Likes"),
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
                                      title: "title",
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
