import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/generation.dart';
import '../../shared/stores/pokemon_list_store.dart';
import 'widgets/pkmn_grid_item.dart';
import 'widgets/pkmn_list_item.dart';

class PkmnListPage extends StatefulWidget {
  const PkmnListPage({super.key});

  @override
  State<PkmnListPage> createState() => _PkmnListPageState();
}

class _PkmnListPageState extends State<PkmnListPage> {
  late PokemonListStore store;

  bool isGridView = false;

  toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final generation = ModalRoute.of(context)!.settings.arguments as Generation;
    final initial = generation.initialId - 1;

    store = context.watch<PokemonListStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generation ${generation.generation}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: toggleView,
              icon: Icon((isGridView) ? Icons.list : Icons.view_compact),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFDC0A2D),
      body: Container(
        margin: const EdgeInsets.only(right: 7, left: 7, bottom: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: (isGridView)
            ? GridView.builder(
                itemCount: generation.total,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 75,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 80,
                ),
                itemBuilder: (context, index) {
                  return PkmnGridItem(store.state.value[index + initial]);
                },
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                itemCount: generation.total,
                itemBuilder: (context, index) {
                  return PkmnListItem(store.state.value[index + initial]);
                },
              ),
      ),
    );
  }
}
