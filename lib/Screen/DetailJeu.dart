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
  @override
  Widget build(BuildContext context) {
    void Like() {}

    void WhishList() {}

    Widget titleSection = Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
            left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
        color: AppColors.input,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 15.0, right: 20.0, bottom: 15.0),
              child: SvgPicture.asset(AppVactorialImages.emptyLikes),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
                  child: Text(
                    widget.game.name,
                    style: const TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  widget.game.publisher[0],
                  style: const TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ));

    Widget buttonSection = Padding(
      padding: const EdgeInsets.all(15.0),
      child: Button(onTap: () {}, name: "DESCRIPTION"),
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
                icon: SvgPicture.asset(AppVactorialImages.like)),
            IconButton(
                onPressed: WhishList,
                icon: SvgPicture.asset(AppVactorialImages.whishlist))
          ],
          title: const Text("Détail du jeu"),
        ),
        body: ListView(
          children: [
            imageSection,
            titleSection,
            buttonSection,
            descriptionSection,
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
