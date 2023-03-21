import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/src/models/get_pokemon.dart';

import '../models/pkmn.dart';
import '../utils/get_color.dart';
import '../widgets/type_widget.dart';

class PkmnDetailPage extends StatelessWidget {
  const PkmnDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pkmn = ModalRoute.of(context)!.settings.arguments as Pkmn;
    final getPokemon = GetPokemon(url: pkmn.url);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(pkmn.capitalize(pkmn.name)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              '#${(pkmn.id.toString().padLeft(4, '0'))}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getPokemon.generatePkmn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Sorry, an unexpected error occurred. ${snapshot.error}'),
            );
          } else {
            final colorType = getType(getPokemon.pokemon.typesOfPokemon[0].types.name);
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.5, 1],
                        colors: [
                          colorType.color,
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 200),
                      Card(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 35),
                              width: double.infinity,
                              child: Text(
                                getPokemon.pokemon.capitalize(getPokemon.pokemon.name),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.outline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.scale),
                                      Text('Weight: ${getPokemon.pokemon.weight.toString()}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.height),
                                      Text('Height: ${getPokemon.pokemon.height.toString()}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TypeWidget(
                                  getPokemon.pokemon.typesOfPokemon[0].types.name,
                                ),
                                if (getPokemon.pokemon.typesOfPokemon.length == 2)
                                  const SizedBox(
                                    width: 10,
                                  ),
                                if (getPokemon.pokemon.typesOfPokemon.length == 2)
                                  TypeWidget(
                                    getPokemon.pokemon.typesOfPokemon[1].types.name,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.translate(
                          offset: const Offset(5, 5),
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaY: 5,
                              sigmaX: 5,
                              tileMode: TileMode.decal,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                              child: Opacity(
                                opacity: 0.5,
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                                  child: Image.network(
                                    getPokemon.pokemon.getImageUrl(),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Image.network(
                          getPokemon.pokemon.getImageUrl(),
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
