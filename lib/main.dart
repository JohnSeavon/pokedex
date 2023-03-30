import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app_widget.dart';
import 'src/data/http/http_client.dart';
import 'src/data/repositories/pokemon_list_repository.dart';
import 'src/shared/stores/pokemon_list_store.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PokemonListStore(
          repository: PokemonListRepository(client: LocalSourceClient())),
      child: const AppWidget(),
    ),
  );
}
