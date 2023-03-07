class gameDescriptionQuestion {
  final String name;
  final int appid;
  final String description;
  final List<String> publisher;
  final bool is_free;
  final String imgURL;
  final String prix;

  gameDescriptionQuestion(
      {required this.name,
      required this.appid,
      required this.description,
      required this.publisher,
      required this.is_free,
      required this.imgURL,
      required this.prix});
}
