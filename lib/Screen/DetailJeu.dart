import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/data/api/databaseService.dart';
import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';
import 'package:steam_app/domain/repo/AvisRepro.dart';
import 'package:steam_app/res/app_vactorial_images.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailJeu extends StatefulWidget {
  DetailJeu({super.key, required this.title, required this.game});

  final gameDescriptionQuestion game;
  final String title;

  @override
  State<DetailJeu> createState() => _DetailJeuState();
}

class _DetailJeuState extends State<DetailJeu> {
  bool isLike = false;
  bool isWish = false;
  bool avis = false;
  bool description = true;
  bool loading = true;
  List _avis = [];

  void avisfun() {
    loadavis();
    setState(() {
      avis = true;
      description = false;
    });
  }

  void loadavis() async {
    final res = await AvisRepro().getAvisGame(widget.game.appid, 40);
    setState(() {
      _avis = res;
      loading = false;
    });
  }

  void descfun() {
    setState(() {
      avis = false;
      description = true;
      loading = true;
    });
  }

  void Like() {
    if (isLike) {
      DatabaseService(Supabase.instance.client).deletelike(widget.game.appid);
      setState(() {
        isLike = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} enlevé des likes")));
    } else {
      DatabaseService(Supabase.instance.client).addlike(widget.game.appid);
      setState(() {
        isLike = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} ajouté au like")));
    }
  }

  Future<void> WishList() async {
    if (isWish) {
      DatabaseService(Supabase.instance.client)
          .deleteWishlist(widget.game.appid);
      setState(() {
        isWish = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} enlevé de la Wishlist")));
    } else {
      DatabaseService(Supabase.instance.client).addWishlist(widget.game.appid);
      setState(() {
        isWish = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.game.name} ajouté de la Wishlist")));
    }
  }

  Future<void> GameWish() async {
    final bool res = await DatabaseService(Supabase.instance.client)
        .isWishlist(widget.game.appid);
    setState(() {
      isWish = res;
    });
  }

  Future<void> GameLike() async {
    final bool res = await DatabaseService(Supabase.instance.client)
        .islike(widget.game.appid);
    setState(() {
      isLike = res;
    });
  }

  late ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    GameLike();
    GameWish();
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Card(
        color: AppColors.input,
        margin: const EdgeInsets.all(16),
        elevation: 5,
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.input,
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: NetworkImage(
                  widget.game.imgURL,
                ),
              ),
            ),
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: AppColors.placeholder)),
                    child: Image.network(
                      widget.game.imgURL,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 70,
                    ),
                  )),
              Expanded(
                flex: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.game.name,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.white)),
                    Text(
                      widget.game.publisher[0],
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: AppColors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Text("Prix : ${widget.game.prix}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: AppColors.white))
                  ],
                ),
              )
            ])));

    Widget buttonSection = description
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft: Radius.circular(8))),
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text(
                      "DESCRIPTION",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: avisfun,
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        backgroundColor: AppColors.background.withOpacity(1.0),
                        side: const BorderSide(color: AppColors.primary)),
                    child: const Text(
                      "AVIS",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: descfun,
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8))),
                        backgroundColor: AppColors.background.withOpacity(1.0),
                        side: const BorderSide(color: AppColors.primary)),
                    child: const Text(
                      "DESCRIPTION",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        backgroundColor: AppColors.primary),
                    child: const Text(
                      "AVIS",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                )
              ],
            ));

    Widget descriptionSection = Padding(
      padding:
          const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
      child: Text(
        widget.game.description,
        style: const TextStyle(
            fontFamily: 'Proxima Nova',
            fontWeight: FontWeight.normal,
            fontSize: 15,
            color: AppColors.white),
      ),
    );

    Widget avisSection = const Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Text('avis'),
    );

    Widget imageSection = Image.network(
      widget.game.imgURL,
      width: 600,
      height: 350,
      fit: BoxFit.cover,
    );

    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          actions: <Widget>[
            IconButton(
                onPressed: Like,
                icon: isLike
                    ? SvgPicture.asset(AppVactorialImages.likeFull)
                    : SvgPicture.asset(AppVactorialImages.like)),
            IconButton(
                onPressed: WishList,
                icon: isWish
                    ? SvgPicture.asset(AppVactorialImages.whishlistFull)
                    : SvgPicture.asset(AppVactorialImages.whishlist))
          ],
          title: const Text("Détail du jeu"),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Container(
                  height: 430,
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      imageSection,
                      Positioned.fill(
                        top: 290,
                        child: Wrap(
                          children: [
                            titleSection,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                buttonSection,
                description
                    ? descriptionSection
                    : loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                  itemCount: _avis.length,
                                  controller: _controller,
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    return Card(
                                      color: AppColors.input,
                                      margin: const EdgeInsets.only(
                                          top: 8,
                                          left: 16,
                                          right: 16,
                                          bottom: 8),
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.input,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(_avis[index].msg,
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .white)),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
              ],
            ),
          ],
        ));
  }

  Column _buildButtonColumn(ColoredBox color, String label) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(
                fontFamily: 'Google Sans',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.white)),
      ],
    );
  }
}
