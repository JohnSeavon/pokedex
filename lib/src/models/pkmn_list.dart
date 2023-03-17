import 'dart:convert';

import 'package:http/http.dart' as http;
import 'pkmn.dart';

class PkmnList {
  final List<Pkmn> _items = [];

  final int initialPkmn;
  final int limitPkmn;

  PkmnList(this.initialPkmn, this.limitPkmn);

  List<Pkmn> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadPkmn() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=$initialPkmn&limit=$limitPkmn'),
    );

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data['results'].forEach((pkmnData) {
      _items.add(
        Pkmn(
          id: (data['results'].indexOf(pkmnData) + initialPkmn + 1),
          name: pkmnData['name'],
          url: pkmnData['url'],
        ),
      );
    });
  }
}
