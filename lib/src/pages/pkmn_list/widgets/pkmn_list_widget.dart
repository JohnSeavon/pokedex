import 'package:flutter/material.dart';
import 'package:pokedex/src/data/models/url_pokemon_model.dart';

import '../../../utils/app_routes.dart';
import '../../../utils/pkmn_utils.dart';

class PkmnListWidget extends StatelessWidget {
  final UrlPokemonModel pkmn;
  const PkmnListWidget(this.pkmn, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.pkmnDetail,
            arguments: pkmn,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                getSpriteUrl(pkmn.id),
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
                  capitalize(pkmn.name),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '#${(pkmn.id.toString().padLeft(4, '0'))}',
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
