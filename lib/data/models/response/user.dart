import 'package:steam_app/domain/entities/userEntity.dart';

class user {
  final String email;
  final String mdp;
  final String Name;
  final List<dynamic> wishList;
  final List<dynamic> like;

  user(this.email, this.mdp, this.Name, this.wishList, this.like);

  userEntiy toEntity() {
    return userEntiy(email: email, mdp: mdp, wish: wishList, like: like);
  }
}

//SteamApp2023
