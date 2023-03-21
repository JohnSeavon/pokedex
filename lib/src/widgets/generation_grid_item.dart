import 'package:flutter/material.dart';
import 'package:pokedex/src/utils/app_routes.dart';

import '../models/generation.dart';

class GenerationGridItem extends StatelessWidget {
  final Generation generation;
  const GenerationGridItem(this.generation, {super.key});

  @override
  Widget build(BuildContext context) {
    bool generationV = false;
    if (generation.generation == 'V') {
      generationV = true;
    }
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.pkmnList, arguments: generation);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 80,
                    bottom: 20,
                    child: Image.network(
                      (generationV)
                          ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId + 1}.png'
                          : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId}.png',
                      width: 90,
                      height: 90,
                    ),
                  ),
                  Positioned(
                    left: 80,
                    bottom: 20,
                    child: Image.network(
                      (generationV)
                          ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId + 7}.png'
                          : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(generation.initialId) + 6}.png',
                      width: 90,
                      height: 90,
                    ),
                  ),
                  Image.network(
                    (generationV)
                        ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId + 4}.png'
                        : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(generation.initialId) + 3}.png',
                    width: 110,
                    height: 110,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Generation ${generation.generation}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontFamily: 'Anton',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
