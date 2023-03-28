import 'package:flutter/material.dart';

import '../../data/models/generation.dart';
import '../../data/repositories/pokemon_list_repository.dart';
import '../../shared/stores/pokemon_list_store.dart';
import '../../shared/widgets/theme_change_icon.dart';
import 'widgets/pkmn_list_widget.dart';

class PkmnListPage extends StatefulWidget {
  const PkmnListPage({super.key});

  @override
  State<PkmnListPage> createState() => _PkmnListPageState();
}

class _PkmnListPageState extends State<PkmnListPage> {
  final PokemonListStore store = PokemonListStore(
    repository: PokemonListRepository(),
  );

  @override
  void initState() {
    super.initState();
    store.getPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    final generation = ModalRoute.of(context)!.settings.arguments as Generation;
    final initial = generation.initialId - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generation ${generation.generation}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        actions: const [
          ThemeChangeIcon(),
        ],
      ),
      backgroundColor: Colors.red,
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
            return Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 5),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                itemCount: generation.total,
                itemBuilder: (context, index) {
                  return PkmnListWidget(store.state.value[index + initial]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
