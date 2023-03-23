import 'dart:convert';

import 'package:pokedex/src/data/http/exceptions.dart';
import 'package:pokedex/src/data/http/http_client.dart';

import '../models/pokemon_model.dart';

abstract class IPokemonRepository {
  Future<PokemonModel> getPokemon(String url);
}

class PokemonRepository implements IPokemonRepository {
  final IHttpClient client;

  PokemonRepository({required this.client});

  @override
  Future<PokemonModel> getPokemon(String url) async {
    final response = await client.get(
      url: url,
    );

    if (response.statusCode == 200) {
      late final PokemonModel pokemon;

      final body = jsonDecode(response.body);

      pokemon = PokemonModel.fromMap(body);

      return pokemon;
    } else if (response.statusCode == 404) {
      throw NotFoundException('Invalid Url');
    } else {
      throw Exception('Unable to load Pokemon');
    }
  }
}
