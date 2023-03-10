import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/Screen/Component/Button.dart';

import '../res/app_images.dart';
import '../res/app_vactorial_images.dart';

class DetailJeu extends StatefulWidget {
  const DetailJeu({super.key, required this.title});

  final String title;
  @override
  State<DetailJeu> createState() => _DetailJeuState();
}

class _DetailJeuState extends State<DetailJeu> {

  @override
  Widget build(BuildContext context) {
    void Like() {
      Navigator.of(context).pushNamed("/like");
    }
    void WhishList() {
      Navigator.of(context).pushNamed("/whishlist");
    }

    void description() {
      Navigator.of(context).pushNamed("/like");
    }

    Widget titleSection = Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left:20.0,top: 0.0,right: 20.0,bottom: 0.0),
        color: Color(0xff2A3238),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20.0,top: 15.0,right: 20.0,bottom: 15.0),
              child: SvgPicture.asset(AppVactorialImages.emptyLikes),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: const Padding(
                    padding: EdgeInsets.only(left:0.0,top: 0.0,right: 0.0,bottom: 10.0),
                    child: Text(
                      'Nom du jeu',
                      style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Text(
                  "Nom de l'éditeur",
                  style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

          ],
        )
    );

    Widget buttonSection = Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      Button(onTap: description, name: "DESCRIPTION"),
      //_buildButtonColumn(ColoredBox(color: Colors.red), "DESCRIPTION"),
    );

    Widget descriptionSection = const Padding(
      padding: EdgeInsets.only(left: 15.0,top: 0.0,right: 15.0,bottom: 0.0),
      child: Text(
        'Bacon ipsum dolor amet rump doner brisket corned beef tri-tip. Burgdoggen t-bone leberkas, tri-tip bacon beef ribs corned beef meatball andouille fatback alcatra strip steak turkey kevin. Short loin andouille cupim boudin, hamburger burgdoggen fatback. Chislic porchetta boudin swine filet mignon tongue t-bone pancetta cupim buffalo chicken ribeye landjaeger. Sausage salami tongue, burgdoggen hamburger pork chop fatback tri-tip t-bone meatloaf alcatra. Boudin pastrami pork belly, strip steak sirloin cow hamburger beef venison alcatra drumstick.',
        style: TextStyle(
            fontFamily: 'Proxima Nova',
            fontWeight: FontWeight.normal,
            fontSize: 15,
            color: AppColors.white),
      ),
    );

    Widget imageSection = Image.asset(
      'assets/png/share.jpg',
      width: 600,
      height:350,
      fit: BoxFit.cover,
    );

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,

        actions: <Widget>[
        IconButton(
            onPressed: Like, icon: SvgPicture.asset(AppVactorialImages.like)),
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
      )

    );
  }

  Column _buildButtonColumn(ColoredBox color, String label){
    return Column(
      children: [
        Text(label,
      style: const TextStyle(
        fontFamily: 'Google Sans',
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: AppColors.white)
        ),

      ],
    );
  }
}
