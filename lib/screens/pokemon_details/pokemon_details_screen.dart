import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatelessWidget {
  static const routeName = 'pokemon-details';

  final String pokemonName;

  const PokemonDetailsScreen({
    Key? key,
    required this.pokemonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(pokemonName),
      ),
    );
  }
}
