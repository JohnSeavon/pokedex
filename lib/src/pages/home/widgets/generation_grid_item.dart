import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/app_routes.dart';

import '../../../data/models/generation.dart';

class GenerationGridItem extends StatelessWidget {
  final Generation generation;
  const GenerationGridItem(this.generation, {super.key});

  @override
  Widget build(BuildContext context) {
    bool generationV = false;
    if (generation.generation == 'V') {
      generationV = true;
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Orientation isPortrait = MediaQuery.of(context).orientation;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.pkmnList, arguments: generation);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: (isPortrait == Orientation.portrait) ? 80 : width * 0.07,
                    bottom: 20,
                    child: Image.network(
                      (generationV)
                          ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId + 1}.png'
                          : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId}.png',
                      width: (isPortrait == Orientation.portrait) ? width * 0.22 : 90,
                      height: (isPortrait == Orientation.portrait) ? 90 : height * 0.18,
                    ),
                  ),
                  Positioned(
                    left: (isPortrait == Orientation.portrait) ? 80 : width * 0.07,
                    bottom: 20,
                    child: Image.network(
                      (generationV)
                          ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId + 7}.png'
                          : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(generation.initialId) + 6}.png',
                      width: (isPortrait == Orientation.portrait) ? width * 0.22 : 90,
                      height: (isPortrait == Orientation.portrait) ? 90 : height * 0.18,
                    ),
                  ),
                  Image.network(
                    (generationV)
                        ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${generation.initialId + 4}.png'
                        : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${(generation.initialId) + 3}.png',
                    width: (isPortrait == Orientation.portrait) ? width * 0.27 : 110,
                    height: (isPortrait == Orientation.portrait) ? 110 : height * 0.20,
                  ),
                ],
              ),
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
