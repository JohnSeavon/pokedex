import 'package:flutter/material.dart';

class BaseStats extends StatelessWidget {
  const BaseStats({
    super.key,
    required this.stats,
    required this.color,
  });

  final List<int> stats;
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
                    Text(stats[0].toString()),
                    Text(stats[1].toString()),
                    Text(stats[2].toString()),
                    Text(stats[3].toString()),
                    Text(stats[4].toString()),
                    Text(stats[5].toString()),
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
                      LinearProgressIndicator(value: stats[0] / 255, color: color),
                      LinearProgressIndicator(value: stats[1] / 255, color: color),
                      LinearProgressIndicator(value: stats[2] / 255, color: color),
                      LinearProgressIndicator(value: stats[3] / 255, color: color),
                      LinearProgressIndicator(value: stats[4] / 255, color: color),
                      LinearProgressIndicator(value: stats[5] / 255, color: color),
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
