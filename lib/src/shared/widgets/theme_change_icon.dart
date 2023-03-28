import 'package:flutter/material.dart';

import '../../app_widget.dart';

class ThemeChangeIcon extends StatelessWidget {
  const ThemeChangeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ThemeMode themeMode = AppWidget.of(context)!.themeMode;
        if (themeMode == ThemeMode.light) {
          AppWidget.of(context)!.changeTheme(ThemeMode.dark);
        } else if (themeMode == ThemeMode.dark) {
          AppWidget.of(context)!.changeTheme(ThemeMode.light);
        }
      },
      icon: const Icon(
        Icons.brightness_4_outlined,
      ),
    );
  }
}
