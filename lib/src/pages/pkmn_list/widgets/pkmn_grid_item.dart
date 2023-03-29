import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/pkmn_utils.dart';

import '../../../data/models/pokemon.dart';
import '../../../shared/app_routes.dart';

class PkmnGridItem extends StatelessWidget {
  final PokemonModel pokemon;
  const PkmnGridItem(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.pkmnDetail,
          arguments: pokemon,
        );
      },
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          children: [
            Image.network(
              getSpriteUrl(pokemon.id),
              width: 75,
              height: 75,
              fit: BoxFit.contain,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                  width: constraints.maxWidth,
                  child: FittedBox(
                    child: Text(
                      pokemon.name,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontFamily: 'Lato',
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
