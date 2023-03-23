import 'dart:convert';

import 'package:pokedex/src/data/http/exceptions.dart';
import 'package:pokedex/src/data/http/http_client.dart';

import '../models/url_pokemon_model.dart';

abstract class IUrlPokemonRepository {
  Future<List<UrlPokemonModel>> getUrlPokemons();
}

class UrlPokemonRepository implements IUrlPokemonRepository {
  final IHttpClient client;

  UrlPokemonRepository({required this.client});

  @override
  Future<List<UrlPokemonModel>> getUrlPokemons() async {
    final response = await client.get(
      url: 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=1008',
    );

    if (response.statusCode == 200) {
      final List<UrlPokemonModel> pokemonList = [];
      int id = 0;

      final body = jsonDecode(response.body);

      body['results'].map((item) {
        final UrlPokemonModel urlpokemon = UrlPokemonModel.fromMap(item, ++id);
        pokemonList.add(urlpokemon);
      }).toList();

      return pokemonList;
    } else if (response.statusCode == 404) {
      throw NotFoundException('Invalid Url');
    } else {
      throw Exception('Unable to load Pokemon');
    }
  }
}
