import 'package:flutter/material.dart';

import '../models/pkmn.dart';
import '../utils/app_routes.dart';

class PkmnListWidget extends StatelessWidget {
  final Pkmn pkmn;
  const PkmnListWidget(this.pkmn, {super.key});

  @override
  Widget build(BuildContext context) {
    const errorImage = 'https://raw.githubusercontent.com/hungps/flutter_pokedex_db/master/sprites/pokemon/0.png';

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
                pkmn.getImageUrl(pkmn.id),
                width: 70,
                height: 70,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    errorImage,
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
                  pkmn.capitalize(pkmn.name),
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
