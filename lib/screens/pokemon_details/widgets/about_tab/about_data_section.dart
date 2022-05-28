import 'package:flutter/material.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/section_and_data.dart';

class PokedexDataSection extends StatelessWidget {
  const PokedexDataSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DataSection(
      title: 'Pokedex Data',
      color: pokemon.types.first.color,
      children: [
        PokeDataRow(
          labelText: 'Height',
          child: DataTextValue(text: '${pokemon.heightInCm}cm.'),
        ),
        PokeDataRow(
          labelText: 'Weight',
          child: DataTextValue(text: '${pokemon.weightInKg}kg.'),
        ),
        PokeDataRow(
          labelText: 'Base Experience',
          child: DataTextValue(text: '${pokemon.baseExperience}'),
        ),
      ],
    );
  }
}