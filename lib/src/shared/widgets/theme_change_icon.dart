import 'package:flutter/material.dart';

import '../../../main.dart';

class ThemeChangeIcon extends StatelessWidget {
  const ThemeChangeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ThemeMode themeMode = MyApp.of(context)!.themeMode;
        if (themeMode == ThemeMode.light) {
          MyApp.of(context)!.changeTheme(ThemeMode.dark);
        } else if (themeMode == ThemeMode.dark) {
          MyApp.of(context)!.changeTheme(ThemeMode.light);
        }
      },
      icon: const Icon(
        Icons.brightness_4_outlined,
      ),
    );
  }
}
