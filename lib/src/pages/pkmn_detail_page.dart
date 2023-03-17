import 'package:flutter/material.dart';

import '../models/pkmn.dart';

class PkmnDetailPage extends StatelessWidget {
  const PkmnDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pkmn = ModalRoute.of(context)!.settings.arguments as Pkmn;

    return Scaffold(
        appBar: AppBar(
          title: Text(pkmn.capitalize(pkmn.name)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  pkmn.getOficialArtUrl(pkmn.id),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  pkmn.capitalize(pkmn.name),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
