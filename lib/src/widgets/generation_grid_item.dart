import 'package:flutter/material.dart';
import 'package:pokedex/src/utils/app_routes.dart';

import '../models/generation.dart';

class GenerationGridItem extends StatelessWidget {
  final Generation generation;
  const GenerationGridItem(this.generation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        footer: GridTileBar(
            title: Text(
          'Generation ${generation.generation}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        )),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.pkmnList, arguments: generation);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId}.png',
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(generation.initialId) + 3}.png',
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(generation.initialId) + 6}.png',
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
