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
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.input,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.05), BlendMode.dstATop),
                  image: NetworkImage(
                    img,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: AppColors.placeholder)),
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 70,
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 170,
                        child: Text(name,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColors.white)),
                      ),
                      Container(
                        width: 170,
                        child: Text(
                          editeur,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: AppColors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Prix : $prix",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: AppColors.white))
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
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
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
    throw UnimplementedError();
  }
}
