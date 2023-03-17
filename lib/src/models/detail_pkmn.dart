import 'package:pokedex/src/models/pkmn.dart';

class DetailPkmn extends Pkmn {
  final int height;
  final int weight;

  DetailPkmn({
    required this.height,
    required this.weight,
    required super.id,
    required super.name,
    required super.url,
  });
}
