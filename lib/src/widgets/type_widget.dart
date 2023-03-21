import 'package:flutter/material.dart';

import '../utils/get_color.dart';

class TypeWidget extends StatelessWidget {
  final String type;
  const TypeWidget(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorType = getType(type);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(17, 3, 15, 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: colorType.color,
      ),
      child: Text(
        type,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
      ),
    );
  }
}
