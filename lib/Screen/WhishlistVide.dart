import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/res/app_vactorial_images.dart';



class WhishlistVide extends StatefulWidget {
  const WhishlistVide({super.key, required this.title});

  final String title;
  @override
  _WhishlistVideState createState() => _WhishlistVideState();
}

class _WhishlistVideState extends State<WhishlistVide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Ma liste de souhaits"),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:0.0,top: 250.0,right: 0.0,bottom: 50.0),
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
          )

      ),
    );
  }
}
