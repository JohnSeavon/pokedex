import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/src/data/models/url_pokemon_model.dart';

import '../../data/http/http_client.dart';
import '../../data/repositories/pokemon_repository.dart';
import '../../utils/get_color.dart';
import '../../utils/pkmn_utils.dart';
import 'stores/pokemon_store.dart';
import 'widgets/type_widget.dart';

class PkmnDetailPage extends StatefulWidget {
  const PkmnDetailPage({super.key});

  @override
  State<PkmnDetailPage> createState() => _PkmnDetailPageState();
}

class _PkmnDetailPageState extends State<PkmnDetailPage> {
  final PokemonStore store = PokemonStore(
    repository: PokemonRepository(
      client: HttpClient(),
    ),
  );

  final pkmn = <String, Object>{};

  @override
  void initState() {
    super.initState();
    //store.getPokemon(pkmn.url);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (pkmn.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final urlpkmn = arg as UrlPokemonModel;
        store.getPokemon(urlpkmn.url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final pkmn = ModalRoute.of(context)!.settings.arguments as UrlPokemonModel;
    // final getPokemon = GetPokemon(url: pkmn.url);

    return AnimatedBuilder(
      animation: Listenable.merge([
        store.isLoading,
        store.error,
        store.state,
      ]),
      builder: (context, child) {
        if (store.isLoading.value) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (store.error.value.isNotEmpty) {
          return const Center(
            child: Text('Sorry, an unexpected error occurred'),
          );
        }
        if (store.state.value.name.isEmpty) {
          return const Center(
            child: Text('The list is empty'),
          );
        } else {
          final colorType = getType(store.state.value.typesOfPokemon[0].types.name);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorType.color,
              centerTitle: false,
              title: Text(
                capitalize(store.state.value.name),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '#${(store.state.value.id.toString().padLeft(4, '0'))}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.4, 1],
                        colors: [
                          colorType.color,
                          Theme.of(context).colorScheme.background,
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
                              padding: const EdgeInsets.only(top: 45),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TypeWidget(
                                    store.state.value.typesOfPokemon[0].types.name,
                                  ),
                                  if (store.state.value.typesOfPokemon.length == 2)
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  if (store.state.value.typesOfPokemon.length == 2)
                                    TypeWidget(
                                      store.state.value.typesOfPokemon[1].types.name,
                                    ),
                                ],
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
                                      Text(' Weight: ${(store.state.value.weight / 10).toString()} kg'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.height),
                                      Text('Height: ${(store.state.value.height / 10).toString()} m'),
                                    ],
                                  ),
                                ],
                              ),
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
                                    getImageUrl(store.state.value.id),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Image.network(
                          getImageUrl(store.state.value.id),
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
