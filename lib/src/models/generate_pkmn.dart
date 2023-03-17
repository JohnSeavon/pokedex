import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/src/models/detail_pkmn.dart';

class GeneratePkmn {
  final String url;
  late final DetailPkmn detailPkmn;

  GeneratePkmn({
    required this.url,
  });

  Future<void> generatePkmn() async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    detailPkmn = DetailPkmn(
      id: data['id'],
      name: data['name'],
      height: data['height'],
      weight: data['weight'],
      url: url,
    );
  }
}
