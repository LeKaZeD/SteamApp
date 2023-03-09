class RequestGameDescription {
  //creation d'une requette argument
  final int appid;
  static const String language = 'french';

  const RequestGameDescription(
      {required this.appid}); // instencier l'id de l'app steam

  Map<String, dynamic> toMap() {
    //argument appler pour la requette
    final querryParameters = {'l': language, 'appids': "$appid"};
    return querryParameters;
  }

  String get GameID {
    //recuperer l'id pour le json
    return "$appid";
  }
}
