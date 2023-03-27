import 'package:flutter/material.dart';

enum ColorTypes {
  normal(Color.fromRGBO(168, 168, 120, 1)),
  fighting(Color.fromRGBO(192, 48, 40, 1)),
  flying(Color.fromRGBO(168, 144, 240, 1)),
  poison(Color.fromRGBO(160, 64, 160, 1)),
  ground(Color.fromRGBO(224, 192, 104, 1)),
  rock(Color.fromRGBO(184, 160, 56, 1)),
  bug(Color.fromRGBO(168, 184, 32, 1)),
  ghost(Color.fromRGBO(112, 88, 152, 1)),
  steel(Color.fromRGBO(184, 184, 208, 1)),
  fire(Color.fromRGBO(240, 128, 48, 1)),
  water(Color.fromRGBO(104, 144, 240, 1)),
  grass(Color.fromRGBO(120, 200, 80, 1)),
  electric(Color.fromRGBO(248, 208, 48, 1)),
  psychic(Color.fromRGBO(248, 88, 136, 1)),
  ice(Color.fromRGBO(152, 216, 216, 1)),
  dragon(Color.fromRGBO(112, 56, 248, 1)),
  dark(Color.fromRGBO(112, 88, 72, 1)),
  fairy(Color.fromRGBO(238, 153, 172, 1)),
  unknown(Color.fromRGBO(104, 160, 144, 1));

  final Color color;

  const ColorTypes(this.color);
}

ColorTypes getType(String type) {
  switch (type) {
    case 'Normal':
      return ColorTypes.normal;
    case 'Fighting':
      return ColorTypes.fighting;
    case 'Flying':
      return ColorTypes.flying;
    case 'Poison':
      return ColorTypes.poison;
    case 'Ground':
      return ColorTypes.ground;
    case 'Rock':
      return ColorTypes.rock;
    case 'Bug':
      return ColorTypes.bug;
    case 'Ghost':
      return ColorTypes.ghost;
    case 'Steel':
      return ColorTypes.steel;
    case 'Fire':
      return ColorTypes.fire;
    case 'Water':
      return ColorTypes.water;
    case 'Grass':
      return ColorTypes.grass;
    case 'Electric':
      return ColorTypes.electric;
    case 'Psychic':
      return ColorTypes.psychic;
    case 'Ice':
      return ColorTypes.ice;
    case 'Dragon':
      return ColorTypes.dragon;
    case 'Dark':
      return ColorTypes.dark;
    case 'Fairy':
      return ColorTypes.fairy;
    default:
      return ColorTypes.unknown;
  }
}
