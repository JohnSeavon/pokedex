class PokemonModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<TypesOfPokemon> typesOfPokemon;

  PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.typesOfPokemon,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      id: map['id'],
      name: map['name'],
      height: map['height'],
      weight: map['weight'],
      typesOfPokemon: (map['types'] as List).map((e) => TypesOfPokemon.fromJson(e)).toList(),
    );
  }
}

class TypesOfPokemon {
  Types types;

  TypesOfPokemon({
    required this.types,
  });

  TypesOfPokemon.fromJson(Map<String, dynamic> map)
      : this(
          types: Types.fromJson(map['type']),
        );

  Map<String, dynamic> toJson() {
    return {
      'type': types,
    };
  }
}

class Types {
  String name;

  Types({required this.name});

  Types.fromJson(Map<String, dynamic> map)
      : this(
          name: map['name'],
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
