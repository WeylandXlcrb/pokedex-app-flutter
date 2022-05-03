import 'package:flutter/material.dart';

class PokemonsScreen extends StatelessWidget {
  static const routeName = 'pokemons';

  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Pokemon List'),
      ),
    );
  }
}
