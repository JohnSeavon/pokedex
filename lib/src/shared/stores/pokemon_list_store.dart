import 'package:flutter/material.dart';

import '../../data/http/exceptions.dart';
import '../../data/models/pokemon.dart';
import '../../data/repositories/pokemon_list_repository.dart';

class PokemonListStore {
  final PokemonListRepository repository;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<PokemonModel>> state = ValueNotifier<List<PokemonModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  PokemonListStore({required this.repository});

  Future getUrlPokemons() async {
    isLoading.value = true;

    try {
      final result = await repository.getPokemonList();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
