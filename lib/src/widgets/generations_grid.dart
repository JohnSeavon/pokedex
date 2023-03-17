import 'package:flutter/material.dart';
import 'package:pokedex/src/models/generation_list.dart';

import '../models/generation.dart';
import 'generation_grid_item.dart';

class GenerationsGrid extends StatelessWidget {
  const GenerationsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Generation> list = generationsList;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 4 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => GenerationGridItem(list[index]),
    );
  }
}
