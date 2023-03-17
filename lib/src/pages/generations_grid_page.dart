import 'package:flutter/material.dart';

import '../widgets/generations_grid.dart';

class GenerationsGridPage extends StatelessWidget {
  const GenerationsGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generations'),
      ),
      body: const GenerationsGrid(),
    );
  }
}
