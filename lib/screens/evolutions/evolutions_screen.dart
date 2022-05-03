import 'package:flutter/material.dart';

class EvolutionsScreen extends StatelessWidget {
  static const routeName = 'evolutions';

  const EvolutionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('EvolutionsScreen'),
      ),
    );
  }
}
