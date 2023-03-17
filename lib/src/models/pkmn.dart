class Pkmn {
  final int id;
  final String name;
  final String url;

  Pkmn({
    required this.id,
    required this.name,
    required this.url,
  });

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String getImageUrl(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  String getOficialArtUrl(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}
