import 'package:flutter/material.dart';
import 'package:pokedex/src/models/pkmn_list.dart';
import 'package:pokedex/src/widgets/pkmn_list_widget.dart';

import '../models/generation.dart';

class PkmnListPage extends StatelessWidget {
  const PkmnListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final generation = ModalRoute.of(context)!.settings.arguments as Generation;
    final list = PkmnList((generation.initialId - 1), generation.total);
    return Scaffold(
      appBar: AppBar(
        title: Text('Generation ${generation.generation}'),
      ),
      body: FutureBuilder(
        future: list.loadPkmn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Sorry, an unexpected error occurred.'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              itemCount: list.itemsCount,
              itemBuilder: (context, index) {
                return PkmnListWidget(list.items[index]);
              },
            );
          }
        },
      ),
    );
  }
}
