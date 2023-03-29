import 'package:flutter/material.dart';

import '../../../data/models/pokemon.dart';
import '../../../shared/app_routes.dart';
import '../../../shared/get_color.dart';
import '../../../shared/pkmn_utils.dart';

class PkmnListItem extends StatelessWidget {
  final PokemonModel pokemon;
  const PkmnListItem(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.pkmnDetail,
            arguments: pokemon,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
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
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    '#${(pokemon.id.toString().padLeft(4, '0'))}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Tooltip(
                      message: pokemon.types.first,
                      verticalOffset: -15,
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration: const Duration(milliseconds: 800),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: getType(pokemon.types.first).color,
                      ),
                      child: Image.asset(
                        'assets/images/types/${pokemon.types.first}.png',
                        height: 25,
                        fit: BoxFit.contain,
                      ),
                    ),
                    if (pokemon.types.length == 2)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Tooltip(
                          message: pokemon.types.last,
                          verticalOffset: -15,
                          triggerMode: TooltipTriggerMode.tap,
                          showDuration: const Duration(milliseconds: 800),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: getType(pokemon.types.last).color,
                          ),
                          child: Image.asset(
                            'assets/images/types/${pokemon.types.last}.png',
                            height: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
