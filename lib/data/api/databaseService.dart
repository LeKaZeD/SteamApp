import 'package:steam_app/data/api/remote_api_Steam.dart';
import 'package:steam_app/data/models/request/requestGameDescription.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final SupabaseClient client;

  DatabaseService(this.client);

  void createUser(AuthResponse res, String userName) async {
    await client.from('Profiles').insert({
      'id': res.session?.user.id,
      'like': [],
      'wish': [],
      'userName': userName
    });
  }

  //recuperer les jeux
  Future<List<gameDescriptionQuestion>> getWishlist() async {
    final data = await client
        .from("Profiles")
        .select('wish')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> array = data['wish'];
    final List<Future<gameDescriptionQuestion>> futures = array.map((element) {
      return RemoteAPISteam()
          .getGame(RequestGameDescription(appid: element))
          .then((value) => value.toEntity());
    }).toList();
    final results = await Future.wait(futures);
    return results;
  }

  //savoir si un jeux fait partie de la wishlist
  Future<bool> isWishlist(dynamic game) async {
    final data = await client
        .from("Profiles")
        .select('wish')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> list = data['wish'];
    return list.contains(game);
  }

  //ajouter un jeux a la liste
  void addWishlist(int gameid) async {
    final data = await client
        .from("Profiles")
        .select('wish')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> array = data['wish'];
    if (!array.contains(gameid)) {
      array.add(gameid);
    }

    final res = await client.from("Profiles").update({
      'wish': array,
    }).eq('id', client.auth.currentSession?.user.id);
  }

//supprimer un jeu de la liste
  void deleteWishlist(int gameid) async {
    final data = await client
        .from("Profiles")
        .select('wish')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> array = data['wish'];
    array.remove(gameid);
    final res = await client.from("Profiles").update({
      'wish': array,
    }).eq('id', client.auth.currentSession?.user.id);
  }

  //like

  //recuperer les jeux
  Future<List<gameDescriptionQuestion>> getLike() async {
    final data = await client
        .from("Profiles")
        .select('like')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> array = data['like'];
    final List<Future<gameDescriptionQuestion>> futures = array.map((element) {
      return RemoteAPISteam()
          .getGame(RequestGameDescription(appid: element))
          .then((value) => value.toEntity());
    }).toList();
    final results = await Future.wait(futures);
    return results;
  }

  //savoir si un jeux fait partie de la wishlist
  Future<bool> islike(dynamic game) async {
    final data = await client
        .from("Profiles")
        .select('like')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> list = data['like'];
    return list.contains(game);
  }

  //ajouter un jeux a la liste
  void addlike(int gameid) async {
    final data = await client
        .from("Profiles")
        .select('like')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> array = data['like'];
    if (!array.contains(gameid)) {
      array.add(gameid);
    }

    final res = await client.from("Profiles").update({
      'like': array,
    }).eq('id', client.auth.currentSession?.user.id);
  }

//supprimer un jeu de la liste
  void deletelike(int gameid) async {
    final data = await client
        .from("Profiles")
        .select('like')
        .eq('id', client.auth.currentSession?.user.id)
        .single() as Map;
    final List<dynamic> array = data['like'];
    array.remove(gameid);

    final res = await client.from("Profiles").update({
      'like': array,
    }).eq('id', client.auth.currentSession?.user.id);
  }
}
