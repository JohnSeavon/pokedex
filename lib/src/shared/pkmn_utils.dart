// Useful functions

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String getSpriteUrl(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}

String getShinySpriteUrl(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/$id.png';
}

String getBackSpriteUrl(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png';
}

String getBackShinySpriteUrl(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/$id.png';
}

String getImageUrl(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}

String getShinyImageUrl(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/$id.png';
}

String getPokemonIconUrl(int id) {
  return 'https://raw.githubusercontent.com/Purukitto/pokemon-data.json/master/images/pokedex/sprites/${id.toString().padLeft(3, '0')}.png';
}
