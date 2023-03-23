class UrlPokemonModel {
  final int id;
  final String name;
  final String url;

  UrlPokemonModel({
    required this.id,
    required this.name,
    required this.url,
  });

  factory UrlPokemonModel.fromMap(Map<String, dynamic> map, int id) {
    return UrlPokemonModel(
      id: id,
      name: map['name'],
      url: map['url'],
    );
  }
}
