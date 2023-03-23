import 'package:flutter/material.dart';

import '../../data/http/http_client.dart';
import '../../data/repositories/url_pokemon_repository.dart';
import '../../data/models/generation.dart';
import 'widgets/pkmn_list_widget.dart';
import 'stores/url_pokemon_store.dart';

class PkmnListPage extends StatefulWidget {
  const PkmnListPage({super.key});

  @override
  State<PkmnListPage> createState() => _PkmnListPageState();
}

class _PkmnListPageState extends State<PkmnListPage> {
  final UrlPokemonStore store = UrlPokemonStore(
    repository: UrlPokemonRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getUrlPokemons();
  }

  @override
  Widget build(BuildContext context) {
    final generation = ModalRoute.of(context)!.settings.arguments as Generation;
    final initial = generation.initialId - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Generation ${generation.generation}'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.error,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (store.error.value.isNotEmpty) {
            return const Center(
              child: Text('Sorry, an unexpected error occurred'),
            );
          }
          if (store.state.value.isEmpty) {
            return const Center(
              child: Text('The list is empty'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              itemCount: generation.total,
              itemBuilder: (context, index) {
                return PkmnListWidget(store.state.value[index + initial]);
              },
            );
          }
        },
      ),
    );
  }
}
