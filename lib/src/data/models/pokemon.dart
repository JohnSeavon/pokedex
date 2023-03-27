class PokemonModel {
  final int id;
  final String name;
  final List<String> types;
  final Stat baseStats;
  final String species;
  final String description;
  final Evolution? evolution;
  final Profile profile;

  PokemonModel({
    required this.id,
    required this.name,
    required this.types,
    required this.baseStats,
    required this.species,
    required this.description,
    required this.evolution,
    required this.profile,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      types: List<String>.from(json['type']),
      baseStats: Stat.fromJson(json['base']),
      species: json['species'],
      description: json['description'],
      evolution: json['evolution'].isEmpty ? null : Evolution.fromJson(json['evolution']),
      profile: Profile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': types,
      'base': baseStats,
      'species': species,
      'description': description,
      'evolution': (evolution == null) ? Evolution(prev: [], next: []) : evolution,
      'profile': profile,
    };
  }
}

class Stat {
  final int hp;
  final int attack;
  final int defense;
  final int spAttack;
  final int spDefense;
  final int speed;

  Stat({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed,
  });

  Stat.fromJson(Map<String, dynamic> json)
      : this(
          hp: json['hp'],
          attack: json['attack'],
          defense: json['defense'],
          spAttack: json['spAttack'],
          spDefense: json['spDefense'],
          speed: json['speed'],
        );

  Map<String, dynamic> toJson() {
    return {
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'spAttack': spAttack,
      'spDefense': spDefense,
      'speed': speed,
    };
  }
}

class Evolution {
  final List<String> prev;
  final List<List<String>> next;

  Evolution({
    required this.prev,
    required this.next,
  });

  Evolution.fromJson(Map<String, dynamic> json)
      : this(
          prev: json.containsKey('prev') ? List<String>.from(json['prev']) : [],
          next: json.containsKey('next') ? (json['next'] as List<dynamic>).map((e) => List<String>.from(e)).toList() : [],
        );

  Map<String, dynamic> toJson() {
    return {
      'prev': prev,
      'next': next,
    };
  }
}

class Profile {
  final String height;
  final String weight;
  final List<String> eggs;
  final List<List<String>> abilities;
  final String gender;

  Profile({
    required this.height,
    required this.weight,
    required this.eggs,
    required this.abilities,
    required this.gender,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : this(
          height: json['height'],
          weight: json['weight'],
          eggs: json.containsKey('egg') ? json['egg'].cast<String>() : [],
          abilities: (json['ability'] as List<dynamic>).map((e) => List<String>.from(e)).toList(),
          gender: json['gender'],
        );

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'egg': eggs,
      'ability': abilities,
      'gender': gender,
    };
  }
}
