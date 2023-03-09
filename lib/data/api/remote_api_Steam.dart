import 'package:steam_app/data/models/request/requestGameDescription.dart';
import 'package:steam_app/data/models/response/GameDescription.dart';
import 'package:steam_app/data/models/response/topgames.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final remoteApiProvider = Provider<RemoteAPISteam>((ref) => RemoteAPISteam());

class RemoteAPISteam {
  //class remote api steam, tout les appeles vers steam sont ici
  Future<List<topGame>> getTopGame() async {
    //recuperation des jeux avec leur classement et leur ID
    try {
      final response = await http.get(Uri.http('api.steampowered.com',
          'ISteamChartsService/GetMostPlayedGames/v1/')); // requete http

      if (response.statusCode == 200) {
        // si valide (code 200)
        final responseData = json.decode(response.body); //conversion en json
        final result = List<Map<String, dynamic>>.from(responseData['response']
            ['ranks']); //liste de cle valeur ici rank et id
        if (result.isNotEmpty) {
          return result
              .map((e) => topGame.fromMap(e))
              .toList(); //conversion vers une liste de TopGame chaque objet possede un rank et un id
        }
      }
    } catch (err) {
      print(err);
    }
    return [];
  }

  Future<gameDescription> getGame(RequestGameDescription request) async {
    //recupere la data d'un jeu
    try {
      final response = await http.get(Uri.http('store.steampowered.com',
          '/api/appdetails', request.toMap())); //requete vers api en http
      if (response.statusCode == 200) {
        // si valide (code 200)
        final responseData = json.decode(response.body); //conversion en json
        final String gameId = request.GameID;
        final result =
            responseData[gameId]['data']; //recuperation d'un tableau cle valeur
        if (result.isNotEmpty) {
          var prix = "free";
          try {
            if (result['is_free'] == false) {
              if (result['price_overview'] != null) {
                if (result['price_overview']['final_formatted'] != null) {
                  prix = result['price_overview']['final_formatted'];
                } else {
                  prix = "free";
                }
              } else {
                prix = "14,99€";
              }
            } else {
              prix = "free";
            }
          } catch (err) {}

          return gameDescription(
              name: result['name'],
              appid: result['steam_appid'],
              description: result['short_description'],
              publisher: result['publishers'],
              is_free: result['is_free'],
              imgURL: result['header_image'],
              prix: prix); //creation d'un objet GameDescription
        }
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err);
    }
    return gameDescription(
        name: "pas",
        appid: 0,
        description: "",
        publisher: [],
        is_free: true,
        imgURL: "",
        prix: ""); //retourne un objet nul si erreur
  }
}
