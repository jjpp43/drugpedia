class DetailModel {
  final String name, intro, characteristics, effects, sideEffects;
  final Uri uri;

  DetailModel.fromJson(Map<String, dynamic> json, String type)
      : name = json[type]['name'],
        uri = Uri.parse(json[type]['uri']),
        intro = json[type]['intro'],
        characteristics = json[type]['characteristics'],
        effects = json[type]['effects'],
        sideEffects = json[type]['side-effects'];
}
