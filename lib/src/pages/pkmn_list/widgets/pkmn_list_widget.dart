import 'package:flutter/material.dart';

import '../../../data/models/pokemon.dart';
import '../../../shared/app_routes.dart';
import '../../../shared/get_color.dart';
import '../../../shared/pkmn_utils.dart';

class PkmnListWidget extends StatelessWidget {
  final PokemonModel pokemon;
  const PkmnListWidget(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorType = getType(pokemon.types.first);
    return Card(
      color: colorType.color,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.pkmnDetail,
            arguments: pokemon,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                getSpriteUrl(pokemon.id),
                width: 70,
                height: 70,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    getSpriteUrl(0),
                    width: 70,
                    height: 70,
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemon.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '#${(pokemon.id.toString().padLeft(4, '0'))}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
