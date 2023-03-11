import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/Screen/Component/Button.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

import '../res/app_images.dart';
import '../res/app_vactorial_images.dart';

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

  void GameLike() {
    setState(() {
      isLike = true;
    });
  }

  void Like() {
    if (isLike) {
      setState(() {
        isLike = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.game.name + " enlevé des likes")));
    } else {
      setState(() {
        isLike = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.game.name + " ajouté au like")));
    }
  }

  void WishList() {
    if (isWish) {
      setState(() {
        isWish = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.game.name + " enlevé de la Wishlist")));
    } else {
      setState(() {
        isWish = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.game.name + " ajouté de la Wishlist")));
    }
  }

  void GameWish() {
    setState(() {
      isWish = true;
    });
  }

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
                    Text("Prix : " + widget.game.prix,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: AppColors.white))
                  ],
                ),
              )
            ])));

    Widget buttonSection = Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onHover: (event) {},
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
              onHover: (event) {},
              onPressed: () {},
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
      //_buildButtonColumn(ColoredBox(color: Colors.red), "DESCRIPTION"),
    );

    Widget descriptionSection = Padding(
      padding:
          const EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
      child: Text(
        widget.game.description,
        style: const TextStyle(
            fontFamily: 'Proxima Nova',
            fontWeight: FontWeight.normal,
            fontSize: 15,
            color: AppColors.white),
      ),
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
          children: [
            Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                imageSection,
                Positioned.fill(
                  top: 290,
                  child: Wrap(
                    children: [
                      titleSection,
                      buttonSection,
                      descriptionSection,
                    ],
                  ),
                )
              ],
            )
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
