import 'package:flutter/material.dart';
import 'package:pokedex/src/data/http/exceptions.dart';

import '../../../data/models/pokemon_model.dart';
import '../../../data/repositories/pokemon_repository.dart';

class PokemonStore {
  final IPokemonRepository repository;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<PokemonModel> state = ValueNotifier<PokemonModel>(PokemonModel(
    id: 0,
    name: '',
    height: 0,
    weight: 0,
    typesOfPokemon: [],
    stats: [],
    abilityList: [],
  ));

  // Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  PokemonStore({required this.repository});

  Future getPokemon(String url) async {
    isLoading.value = true;

    try {
      final result = await repository.getPokemon(url);
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
