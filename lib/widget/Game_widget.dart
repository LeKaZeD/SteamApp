import 'package:flutter/material.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';

import '../AppColors.dart';

class Gamewidget extends StatelessWidget {
  final gameDescriptionQuestion game;
  final Function() onTap;

  Gamewidget({super.key, required this.game, required this.onTap});

  void gameDescription() {}

  @override
  Widget build(BuildContext context) {
    return game.name != "pas"
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
                    game.imgURL,
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
                          game.imgURL,
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
                        Text(game.name,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.white)),
                        Text(
                          game.publisher[0],
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        Text("Prix : ${game.prix}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: AppColors.white))
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 39.0),
                          child: Column(
                            children: [
                              Text(
                                "En savoir",
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 15),
                              ),
                              Text(
                                "plus",
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 15),
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
