import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/app_routes.dart';

import '../../../data/models/generation.dart';
import '../../../shared/pkmn_utils.dart';

class GenerationGridItem extends StatelessWidget {
  final Generation generation;
  const GenerationGridItem(this.generation, {super.key});

  @override
  Widget build(BuildContext context) {
    bool generationV = false;
    if (generation.generation == 'V') {
      generationV = true;
    }

    final theme = Theme.of(context);

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
                      getImageUrl(generation.initialId + ((generationV) ? 1 : 0)),
                      width: (isPortrait == Orientation.portrait) ? width * 0.22 : 90,
                      height: (isPortrait == Orientation.portrait) ? 90 : height * 0.18,
                    ),
                  ),
                  Positioned(
                    left: (isPortrait == Orientation.portrait) ? 80 : width * 0.07,
                    bottom: 20,
                    child: Image.network(
                      getImageUrl(generation.initialId + ((generationV) ? 7 : 6)),
                      width: (isPortrait == Orientation.portrait) ? width * 0.22 : 90,
                      height: (isPortrait == Orientation.portrait) ? 90 : height * 0.18,
                    ),
                  ),
                  Image.network(
                    getImageUrl(generation.initialId + ((generationV) ? 4 : 3)),
                    width: (isPortrait == Orientation.portrait) ? width * 0.27 : 110,
                    height: (isPortrait == Orientation.portrait) ? 110 : height * 0.20,
                  ),
                ],
              ),
              Text(
                'Generation ${generation.generation}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
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
