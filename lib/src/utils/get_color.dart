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
    case 'normal':
      return ColorTypes.normal;
    case 'fighting':
      return ColorTypes.fighting;
    case 'flying':
      return ColorTypes.flying;
    case 'poison':
      return ColorTypes.poison;
    case 'ground':
      return ColorTypes.ground;
    case 'rock':
      return ColorTypes.rock;
    case 'bug':
      return ColorTypes.bug;
    case 'ghost':
      return ColorTypes.ghost;
    case 'steel':
      return ColorTypes.steel;
    case 'fire':
      return ColorTypes.fire;
    case 'water':
      return ColorTypes.water;
    case 'grass':
      return ColorTypes.grass;
    case 'electric':
      return ColorTypes.electric;
    case 'psychic':
      return ColorTypes.psychic;
    case 'ice':
      return ColorTypes.ice;
    case 'dragon':
      return ColorTypes.dragon;
    case 'dark':
      return ColorTypes.dark;
    case 'fairy':
      return ColorTypes.fairy;
    default:
      return ColorTypes.unknown;
  }
}
