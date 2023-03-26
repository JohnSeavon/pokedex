import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/src/utils/pkmn_utils.dart';

import '../../data/http/http_client.dart';
import '../../data/models/url_pokemon_model.dart';
import '../../data/repositories/pokemon_repository.dart';
import '../../utils/get_color.dart';
import 'stores/pokemon_store.dart';
import 'widgets/base_stats.dart';
import 'widgets/sprites_card.dart';
import 'widgets/type_widget.dart';

class PokemonInfoPage extends StatefulWidget {
  const PokemonInfoPage({super.key});

  @override
  State<PokemonInfoPage> createState() => _PokemonInfoPageState();
}

class _PokemonInfoPageState extends State<PokemonInfoPage> {
  final PokemonStore store = PokemonStore(
    repository: PokemonRepository(
      client: HttpClient(),
    ),
  );

  final pkmn = <String, Object>{};

  bool selectedShiny = false;

  isSelectedShiny() {
    setState(() {
      selectedShiny = !selectedShiny;
    });
  }

  @override
  void initState() {
    super.initState();
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
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: Listenable.merge([
        store.isLoading,
        store.error,
        store.state,
      ]),
      builder: (context, child) {
        if (store.isLoading.value) {
          return Container(
            color: theme.colorScheme.background,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (store.error.value.isNotEmpty) {
          return Container(
            color: theme.colorScheme.background,
            child: const Center(
              child: Text('Sorry, an unexpected error occurred'),
            ),
          );
        }
        if (store.state.value.name.isEmpty) {
          return Container(
            color: theme.colorScheme.background,
            child: const Center(
              child: Text('The list is empty'),
            ),
          );
        } else {
          final List<int> stats = store.state.value.stats.map((e) => e.baseStat).toList();
          final colorType = getType(store.state.value.typesOfPokemon[0].types.name);
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          Orientation isPortrait = MediaQuery.of(context).orientation;

          return Scaffold(
            backgroundColor: colorType.color,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: false,
              title: Text(
                capitalize(store.state.value.name),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
              actions: const [
                Icon(
                  Icons.favorite_border_sharp,
                ),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.brightness_4_outlined,
                  ),
                ),
              ],
            ),
            // ! Stack
            body: Stack(
              children: [
                // ! pokeball in background
                Positioned(
                  right: 5,
                  top: 30,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/images/pokeball.png',
                      width: width * 0.8,
                      height: (isPortrait == Orientation.portrait) ? width : height * 0.4,
                      fit: BoxFit.contain,
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
                // ! fake top draggable
                Container(
                  margin: EdgeInsets.only(top: (isPortrait == Orientation.portrait) ? height * 0.36 : height * 0.5),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(42),
                      topRight: Radius.circular(42),
                    ),
                  ),
                ),
                // ! Pokemon image
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (isPortrait == Orientation.portrait) ? height * 0.4 : height * 0.6,
                      width: (isPortrait == Orientation.portrait) ? width * 0.5 : height * 0.4,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
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
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => isSelectedShiny(),
                            child: Image.network(
                              (selectedShiny) ? getShinyImageUrl(store.state.value.id) : getImageUrl(store.state.value.id),
                              fit: BoxFit.contain,
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // ! shiny button and pokemon id
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  padding: const EdgeInsets.only(left: 15, right: 25),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        isSelected: selectedShiny,
                        tooltip: 'Shiny',
                        color: theme.colorScheme.background,
                        onPressed: isSelectedShiny,
                        icon: const Icon(Icons.auto_awesome_outlined),
                        selectedIcon: const Icon(Icons.auto_awesome),
                        style: IconButton.styleFrom(
                          foregroundColor: selectedShiny ? colorType.color : theme.colorScheme.background,
                          backgroundColor: selectedShiny ? theme.colorScheme.background.withAlpha(150) : Colors.transparent,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 2),
                        child: Text(
                          '#${(store.state.value.id.toString().padLeft(4, '0'))}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.background,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ! Pokemon Info
                DraggableScrollableSheet(
                  initialChildSize: (isPortrait == Orientation.portrait) ? 0.6 : 0.4,
                  minChildSize: (isPortrait == Orientation.portrait) ? 0.6 : 0.4,
                  maxChildSize: (isPortrait == Orientation.portrait) ? 0.9 : 0.8,
                  snap: true,
                  snapSizes: [((isPortrait == Orientation.portrait) ? 0.6 : 0.4), ((isPortrait == Orientation.portrait) ? 0.9 : 0.8)],
                  builder: (context, scrollController) => ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(42),
                      topRight: Radius.circular(42),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(42),
                            topRight: Radius.circular(42),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
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
                                  // ! weight and height
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
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                        child: Text(
                                          'Abilities:',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Lato',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: Card(
                                          color: colorType.color.withAlpha(70),
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                            child: Text(
                                              capitalize(store.state.value.abilityList[0].abilities.abilityName),
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (store.state.value.abilityList.length == 2)
                                        Card(
                                          color: colorType.color.withAlpha(70),
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                            child: Text(
                                              capitalize(store.state.value.abilityList[1].abilities.abilityName),
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Divider(),
                                  ),
                                  BaseStats(stats: stats, color: colorType.color),
                                  const SizedBox(height: 10),
                                  SpritesCard(id: store.state.value.id),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
