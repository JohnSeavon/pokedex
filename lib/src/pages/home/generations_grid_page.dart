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
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokéDex'),
        actions: const [
          ThemeChangeIcon(),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) => GenerationGridItem(list[index]),
      ),
    );
  }
}
