class RequestGameName {
  //creation d'une requette argument
  final String name;

  const RequestGameName({required this.name}); // instencier l'id de l'app steam

  Map<String, dynamic> toMap() {
    //argument appler pour la requette
    final querryParameters = {'/': "$name"};
    return querryParameters;
  }

  String getName() {
    return name;
  }
}
