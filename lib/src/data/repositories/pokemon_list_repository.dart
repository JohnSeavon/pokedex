import 'dart:convert';

import 'package:pokedex/src/data/http/http_client.dart';

import '../models/pokemon.dart';

abstract class IPokemonListRepository {
  Future<List<PokemonModel>> getPokemonList();
}

class PokemonListRepository implements IPokemonListRepository {
  final IDataSourceClient client;

  PokemonListRepository({
    required this.client,
  });

  @override
  Future<List<PokemonModel>> getPokemonList() async {
    final String response = await client.get(source: 'assets/data/poke_data.json');

    if (response.isNotEmpty) {
      final List<PokemonModel> pokemonList = [];

      final body = jsonDecode(response);

      body['results'].map((item) {
        final PokemonModel pokemon = PokemonModel.fromJson(item);
        pokemonList.add(pokemon);
      }).toList();
      return pokemonList;
    } else {
      throw Exception('Not found');
    }
  }
}
