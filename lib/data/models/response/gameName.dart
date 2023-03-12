class gameName {
  final int appid;

  gameName({required this.appid});

  @override
  List<Object> get props => [appid];

  factory gameName.fromMap(Map<String, dynamic> map) {
    return gameName(appid: int.parse(map['appid']) ?? 0);
  }
}
