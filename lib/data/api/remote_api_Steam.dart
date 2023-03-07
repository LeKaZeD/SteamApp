import 'package:steam_app/data/models/request/requestGameDescription.dart';
import 'package:steam_app/data/models/response/GameDescription.dart';
import 'package:steam_app/data/models/response/topgames.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/request/question_request_topGames.dart';

class RemoteAPIRank {
  Future<List<topGame>> getTopGame(RequestTopGame request) async {
    try {
      final response = await http.get(Uri.http('api.steampowered.com',
          'ISteamChartsService/GetMostPlayedGames/v1/'));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        final result =
        List<Map<String, dynamic>>.from(responseData['response']['ranks']);
        if (result.isNotEmpty) {
          return result.map((e) => topGame.fromMap(e)).toList();
        }
      }
    } catch (err) {
      print(err);
    }
    return [];
  }

  Future<gameDescription> getGame(RequestGameDescription request) async {
    try {

    } catch (err) {
      print(err);
    }
    return gameDescription(name: "",
        appid: 0,
        description: "",
        publisher: [],
        is_free: true,
        imgURL: "",
        prix: "");
  }
}
