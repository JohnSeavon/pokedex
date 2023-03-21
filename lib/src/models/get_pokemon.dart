import 'dart:convert';

import 'package:http/http.dart' as http;

import 'pokemon.dart';

class GetPokemon {
  final String url;
  late final Pokemon pokemon;

  GetPokemon({
    required this.url,
  });

  Future<void> generatePkmn() async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    pokemon = Pokemon.fromJson(data);
  }
}
