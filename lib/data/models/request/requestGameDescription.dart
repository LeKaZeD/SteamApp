class RequestGameDescription {
  final int appid;
  final String language = 'french';

  const RequestGameDescription({required this.appid});

  Map<String, dynamic> toMap() {
    final querryParameters = {
      'l': language,
      'appid': appid
    };
    return querryParameters;
  }

}