import 'package:flutter/material.dart';

import '../../data/models/generation.dart';
import '../../data/repositories/generation_list.dart';
import '../../shared/widgets/theme_change_icon.dart';
import 'widgets/generation_grid_item.dart';

class GenerationsGridPage extends StatelessWidget {
  const GenerationsGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Generation> list = generationsList;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PokéDex',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.background,
          ),
        ),
        actions: const [
          ThemeChangeIcon(),
        ],
      ),
      backgroundColor: Colors.red,
      body: Container(
          margin: const EdgeInsets.only(right: 10, left: 10, bottom: 5),
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
            itemBuilder: (context, index) => GenerationGridItem(list[index]),
          )),
    );
  }
}
