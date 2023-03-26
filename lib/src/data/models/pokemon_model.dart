class PokemonModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<TypesOfPokemon> typesOfPokemon;
  final List<Stat> stats;
  final List<AbilityList> abilityList;

  PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.typesOfPokemon,
    required this.stats,
    required this.abilityList,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      id: map['id'],
      name: map['name'],
      height: map['height'],
      weight: map['weight'],
      typesOfPokemon: (map['types'] as List).map((e) => TypesOfPokemon.fromMap(e)).toList(),
      stats: (map['stats'] as List).map((e) => Stat.fromMap(e)).toList(),
      abilityList: (map['abilities'] as List).map((e) => AbilityList.fromMap(e)).toList(),
    );
  }
}

class TypesOfPokemon {
  final Types types;

  TypesOfPokemon({
    required this.types,
  });

  TypesOfPokemon.fromMap(Map<String, dynamic> map)
      : this(
          types: Types.fromMap(map['type']),
        );

  Map<String, dynamic> toMap() {
    return {
      'type': types,
    };
  }
}

class Types {
  final String name;

  Types({required this.name});

  Types.fromMap(Map<String, dynamic> map)
      : this(
          name: map['name'],
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}

class Stat {
  final int baseStat;

  Stat({required this.baseStat});

  Stat.fromMap(Map<String, dynamic> map)
      : this(
          baseStat: map['base_stat'],
        );

  Map<String, dynamic> toMap() {
    return {
      'name': baseStat,
    };
  }
}

class AbilityList {
  final Ability abilities;

  AbilityList({
    required this.abilities,
  });

  AbilityList.fromMap(Map<String, dynamic> map)
      : this(
          abilities: Ability.fromMap(map['ability']),
        );

  Map<String, dynamic> toMap() {
    return {
      'ability': abilities,
    };
  }
}

class Ability {
  final String abilityName;

  Ability({required this.abilityName});

  Ability.fromMap(Map<String, dynamic> map)
      : this(
          abilityName: map['name'],
        );

  Map<String, dynamic> toMap() {
    return {
      'name': abilityName,
    };
  }
}
