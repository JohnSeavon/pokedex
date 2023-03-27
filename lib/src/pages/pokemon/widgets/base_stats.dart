import 'package:flutter/material.dart';

import '../../../data/models/pokemon.dart';

class BaseStats extends StatelessWidget {
  const BaseStats({
    super.key,
    required this.stats,
    required this.color,
  });

  final Stat stats;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statStyle = theme.textTheme.bodyMedium?.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Base Stats',
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('HP', style: statStyle),
                    Text('ATK', style: statStyle),
                    Text('DEF', style: statStyle),
                    Text('SATK', style: statStyle),
                    Text('SDEF', style: statStyle),
                    Text('SPD', style: statStyle),
                  ],
                ),
              ),
              Container(
                height: 140,
                width: 2.0,
                color: theme.colorScheme.outline.withOpacity(0.5),
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
              SizedBox(
                height: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(stats.hp.toString()),
                    Text(stats.attack.toString()),
                    Text(stats.defense.toString()),
                    Text(stats.spAttack.toString()),
                    Text(stats.spDefense.toString()),
                    Text(stats.speed.toString()),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearProgressIndicator(value: stats.hp / 255, color: color),
                      LinearProgressIndicator(value: stats.attack / 255, color: color),
                      LinearProgressIndicator(value: stats.defense / 255, color: color),
                      LinearProgressIndicator(value: stats.spAttack / 255, color: color),
                      LinearProgressIndicator(value: stats.spDefense / 255, color: color),
                      LinearProgressIndicator(value: stats.speed / 255, color: color),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
