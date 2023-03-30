import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/stores/pokemon_list_store.dart';
import 'package:provider/provider.dart';

import '../../app_widget.dart';
import '../../data/models/generation.dart';
import '../../data/repositories/generation_list.dart';
import 'widgets/generation_grid_item.dart';

class GenerationsGridPage extends StatefulWidget {
  const GenerationsGridPage({super.key});

  @override
  State<GenerationsGridPage> createState() => _GenerationsGridPageState();
}

class _GenerationsGridPageState extends State<GenerationsGridPage> {
  late PokemonListStore store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PokemonListStore>(context, listen: false).getPokemonList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Generation> list = generationsList;
    final theme = Theme.of(context);

    store = context.watch<PokemonListStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PokéDex',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.background,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  ThemeMode themeMode = AppWidget.of(context)!.themeMode;
                  if (themeMode == ThemeMode.light) {
                    AppWidget.of(context)!.changeTheme(ThemeMode.dark);
                  } else if (themeMode == ThemeMode.dark) {
                    AppWidget.of(context)!.changeTheme(ThemeMode.light);
                  }
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              )),
        ],
      ),
      backgroundColor: const Color(0xFFDC0A2D),
      body: Container(
          margin: const EdgeInsets.only(right: 7, left: 7, bottom: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  GenerationGridItem(list[index]))),
    );
  }
}
