import 'package:flutter/material.dart';

import '../../../shared/get_color.dart';

class TypeWidget extends StatelessWidget {
  final String type;
  const TypeWidget(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorType = getType(type);
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(17, 3, 15, 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: colorType.color,
      ),
      child: Text(
        type,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.background,
        ),
      ),
    );
  }
}
