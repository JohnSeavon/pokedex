import 'dart:convert';

import 'poke_data.dart';
import '../models/pokemon.dart';

class PokemonListRepository {
  Future<List<PokemonModel>> getPokemonList() async {
    final List<PokemonModel> pokemonList = [];

    final body = jsonDecode(pokeData);

    body['results'].map((item) {
      final PokemonModel pokemon = PokemonModel.fromJson(item);
      pokemonList.add(pokemon);
    }).toList();
    return pokemonList;
  }
}
