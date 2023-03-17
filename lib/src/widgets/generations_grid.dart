import 'package:flutter/material.dart';
import 'package:pokedex/src/models/generation_list.dart';

import '../models/generation.dart';
import 'generation_grid_item.dart';

class GenerationsGrid extends StatelessWidget {
  const GenerationsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Generation> list = generationsList;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) => GenerationGridItem(list[index]),
    );
  }
}
