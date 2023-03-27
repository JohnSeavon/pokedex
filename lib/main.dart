import 'package:flutter/material.dart';

import 'src/shared/themes/themes.dart';
import 'src/shared/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
