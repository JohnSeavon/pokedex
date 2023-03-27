import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/pkmn_utils.dart';

import '../../data/models/pokemon.dart';
import '../../shared/get_color.dart';
import '../../shared/widgets/theme_change_icon.dart';
import 'widgets/base_stats.dart';
import 'widgets/sprites_card.dart';
import 'widgets/type_widget.dart';

class PokemonInfoPage extends StatefulWidget {
  const PokemonInfoPage({super.key});

  @override
  State<PokemonInfoPage> createState() => _PokemonInfoPageState();
}

class _PokemonInfoPageState extends State<PokemonInfoPage> {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pokemon = ModalRoute.of(context)!.settings.arguments as PokemonModel;
    final colorType = getType(pokemon.types.first);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Orientation isPortrait = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: colorType.color,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pokemon.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.background,
              ),
            ),
            Text(
              pokemon.species,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.background,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(
            Icons.favorite_border_sharp,
          ),
          SizedBox(width: 10),
          ThemeChangeIcon(),
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
          Positioned(
            top: height * 0.3,
            left: 10,
            child: (pokemon.id == 1)
                ? const SizedBox.shrink()
                : const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.chevron_left),
                  ),
          ),
          Positioned(
            top: height * 0.3,
            right: 10,
            child: (pokemon.id == 1008)
                ? const SizedBox.shrink()
                : const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.chevron_right),
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
                                getImageUrl(pokemon.id),
                                errorBuilder: (context, error, stackTrace) => const Center(
                                  child: Text('Check your internet connection'),
                                ),
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
                        (selectedShiny) ? getShinyImageUrl(pokemon.id) : getImageUrl(pokemon.id),
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
            margin: const EdgeInsets.only(top: 85),
            padding: const EdgeInsets.only(left: 15, right: 25),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: isSelectedShiny,
                  style: TextButton.styleFrom(
                    foregroundColor: selectedShiny ? Color.lerp(theme.colorScheme.background, Colors.black, 0.1) : theme.colorScheme.background,
                    backgroundColor: selectedShiny ? Color.lerp(colorType.color, Colors.black, 0.2) : Color.lerp(colorType.color, Colors.white, 0.15),
                    shadowColor: selectedShiny ? Colors.white : Colors.black54,
                    elevation: 1,
                  ),
                  child: const Icon(Icons.auto_awesome_outlined),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 2),
                  child: Text(
                    '#${(pokemon.id.toString().padLeft(4, '0'))}',
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
            initialChildSize: (isPortrait == Orientation.portrait) ? 0.59 : 0.38,
            minChildSize: (isPortrait == Orientation.portrait) ? 0.59 : 0.38,
            maxChildSize: (isPortrait == Orientation.portrait) ? 0.9 : 0.8,
            snap: true,
            snapSizes: [((isPortrait == Orientation.portrait) ? 0.59 : 0.38), ((isPortrait == Orientation.portrait) ? 0.9 : 0.8)],
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
                                  pokemon.types.first,
                                ),
                                if (pokemon.types.length == 2)
                                  const SizedBox(
                                    width: 10,
                                  ),
                                if (pokemon.types.length == 2)
                                  TypeWidget(
                                    pokemon.types.last,
                                  ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                'About',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colorType.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12, right: 20, left: 20),
                              child: Text(
                                pokemon.description,
                                textAlign: TextAlign.center,
                              ),
                            ),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                              child: Row(
                                children: [
                                  Card(
                                    color: colorType.color.withAlpha(70),
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      child: Text(
                                        capitalize(pokemon.profile.abilities[0][0]),
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                  if (pokemon.profile.abilities.length > 1)
                                    Card(
                                      color: colorType.color.withAlpha(70),
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        child: Text(
                                          capitalize(pokemon.profile.abilities[1][0]),
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ),
                                    ),
                                  if (pokemon.profile.abilities.length > 2)
                                    Card(
                                      color: colorType.color.withAlpha(70),
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        child: Text(
                                          capitalize(pokemon.profile.abilities[2][0]),
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(),
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
                                      Text(' Weight: ${pokemon.profile.weight}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.height),
                                      Text('Height: ${pokemon.profile.height}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(),
                            ),
                            BaseStats(stats: pokemon.baseStats, color: colorType.color),
                            const SizedBox(height: 10),
                            SpritesCard(id: pokemon.id),
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
}
