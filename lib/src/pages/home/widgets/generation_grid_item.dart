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
    double width = MediaQuery.of(context).size.width;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.pkmnList, arguments: generation);
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
                    right: 80,
                    bottom: 20,
                    child: Image.network(
                      getImageUrl(
                          generation.initialId + ((generationV) ? 1 : 0)),
                      width: width * 0.22,
                      height: 90,
                    ),
                  ),
                  Positioned(
                    left: 80,
                    bottom: 20,
                    child: Image.network(
                      getImageUrl(
                          generation.initialId + ((generationV) ? 7 : 6)),
                      width: width * 0.22,
                      height: 90,
                    ),
                  ),
                  Image.network(
                    getImageUrl(generation.initialId + ((generationV) ? 4 : 3)),
                    width: width * 0.27,
                    height: 110,
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
