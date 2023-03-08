import 'package:flutter/material.dart';
import 'package:steam_app/data/api/remote_api_Steam.dart';

import '../AppColors.dart';

class Gamewidget extends StatelessWidget {
  Gamewidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: Image.network(
                'https://m.media-amazon.com/images/I/51NnxrCKFhL._SX387_BO1,204,203,200_.jpg',
                fit: BoxFit.cover,
                height: 90,
                width: 60,
              )),
          Column(
            children: const [
              Text("Hogwards legacy"),
              Text("Nom editeur"),
              Text("")
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text(
              "En savoir plus",
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
    throw UnimplementedError();
  }
}
