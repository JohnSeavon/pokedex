import 'package:flutter/material.dart';
import 'package:pokedex/src/models/pkmn.dart';
import 'package:pokedex/src/utils/app_routes.dart';

class PkmnListWidget extends StatelessWidget {
  final Pkmn pkmn;
  const PkmnListWidget(this.pkmn, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(pkmn.getImageUrl(pkmn.id), scale: 2),
        title: Text(pkmn.capitalize(pkmn.name)),
        subtitle: Text('#${(pkmn.id.toString().padLeft(4, '0'))}'),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.pkmnDetail,
            arguments: pkmn,
          );
        },
      ),
    );
  }
}
