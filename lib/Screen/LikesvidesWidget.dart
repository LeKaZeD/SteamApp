import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/res/app_vactorial_images.dart';



class LikesvidesWidget extends StatefulWidget {
  const LikesvidesWidget({super.key, required this.title});

  final String title;
  @override
  _LikesvidesWidgetState createState() => _LikesvidesWidgetState();
}

class _LikesvidesWidgetState extends State<LikesvidesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: Text("Mes Likes"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:0.0,top: 250.0,right: 0.0,bottom: 50.0),
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
        )

          ),
        );
  }
}
