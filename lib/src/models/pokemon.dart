class Pokemon {
  final String name;
  final int id;
  final int height;
  final int weight;
  final List<TypesOfPokemon> typesOfPokemon;

  Pokemon({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
    required this.typesOfPokemon,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      height: json['height'],
      weight: json['weight'],
      typesOfPokemon: (json['types'] as List).map((e) => TypesOfPokemon.fromJson(e)).toList(),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String getSpriteUrl() {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  String getImageUrl() {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}

class TypesOfPokemon {
  int slot;
  Types types;

  TypesOfPokemon({
    required this.slot,
    required this.types,
  });

  TypesOfPokemon.fromJson(Map<String, dynamic> json)
      : this(
          slot: json['slot'],
          types: Types.fromJson(json['type']),
        );

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': types,
    };
  }
}

class Types {
  String name;

  Types({required this.name});

  Types.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
