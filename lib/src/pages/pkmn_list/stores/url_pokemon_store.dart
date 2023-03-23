import 'package:flutter/material.dart';
import 'package:pokedex/src/data/http/exceptions.dart';
import 'package:pokedex/src/data/models/url_pokemon_model.dart';
import 'package:pokedex/src/data/repositories/url_pokemon_repository.dart';

class UrlPokemonStore {
  final IUrlPokemonRepository repository;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<UrlPokemonModel>> state = ValueNotifier<List<UrlPokemonModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  UrlPokemonStore({required this.repository});

  Future getUrlPokemons() async {
    isLoading.value = true;

    try {
      final result = await repository.getUrlPokemons();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
