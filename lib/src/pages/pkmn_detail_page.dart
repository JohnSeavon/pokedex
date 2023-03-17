import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/src/models/generate_pkmn.dart';

import '../models/pkmn.dart';

class PkmnDetailPage extends StatelessWidget {
  const PkmnDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pkmn = ModalRoute.of(context)!.settings.arguments as Pkmn;
    final generatePkmn = GeneratePkmn(url: pkmn.url);
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
        future: generatePkmn.generatePkmn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Sorry, an unexpected error occurred. ${snapshot.error}'),
            );
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
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
                                generatePkmn.detailPkmn.capitalize(generatePkmn.detailPkmn.name),
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
                                      Text('Weight: ${generatePkmn.detailPkmn.weight.toString()}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.height),
                                      Text('Height: ${generatePkmn.detailPkmn.height.toString()}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                                    generatePkmn.detailPkmn.getOficialArtUrl(generatePkmn.detailPkmn.id),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Image.network(
                          generatePkmn.detailPkmn.getOficialArtUrl(generatePkmn.detailPkmn.id),
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
