import 'package:flutter/material.dart';
import 'package:steam_app/data/api/remote_api_Steam.dart';

import '../AppColors.dart';

class Gamewidget extends StatelessWidget {
  final String name;
  final String editeur;
  final String prix;
  final String img;

  Gamewidget(
      {super.key,
      required this.name,
      required this.editeur,
      required this.prix,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return name != "pas"
        ? Card(
            color: AppColors.input,
            margin: const EdgeInsets.all(8),
            elevation: 5,
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 70,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(name,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColors.white)),
                    ),
                    Text(
                      editeur,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: AppColors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Text("Prix : $prix",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: AppColors.white))
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary),
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 39.0),
                      child: Column(
                        children: const [
                          Text(
                            "En savoir",
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            "plus",
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          )
        : Container();
    throw UnimplementedError();
  }
}
