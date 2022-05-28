import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/section_and_data.dart';

class SpeciesDataSection extends StatelessWidget {
  final Pokemon pokemon;

  const SpeciesDataSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonSpecies>(
      future: context.read<PokemonsRepo>().getSpeciesByName(pokemon.name),
      builder: (_, snapshot) {
        final List<Widget> children;

        if (snapshot.hasError) {
          children = [const Text('Unable to fetch data')];
        } else if (snapshot.hasData) {
          final species = snapshot.data!;

          children = [
            Text(
              species.flavorTextDefault.text.replaceAll(RegExp(r'\n'), ' '),
            ),
            PokeDataRow(
              labelText: 'Genus',
              child: DataTextValue(text: species.genusDefault.genus),
            ),
            PokeDataRow(
              labelText: 'Base Happiness',
              child: DataTextValue(text: '${species.baseHappiness}'),
            ),
            if (species.isBaby) const DataTextValue(text: 'Baby Pokemon'),
            if (species.isLegendary) const DataTextValue(text: 'Legendary'),
            if (species.isMythical) const DataTextValue(text: 'Mythical'),
            PokeDataRow(
              labelText: 'Gender Rate',
              child: species.isGenderless
                  ? const DataTextValue(text: 'Genderless')
                  : Row(
                      children: [
                        const Icon(Icons.female, color: Colors.pinkAccent),
                        Text('${species.genderRateFemale}%'),
                        const SizedBox(width: 8.0),
                        const Icon(Icons.male, color: Colors.lightBlue),
                        Text('${species.genderRateMale}%'),
                      ],
                    ),
            ),
            if (!species.isGenderless)
              PokeDataRow(
                labelText: 'Gender visual difference',
                child: DataTextValue(
                  text: species.hasGenderDifferences ? 'Differ' : 'Identical',
                ),
              ),
            PokeDataRow(
              labelText: 'Capture Rate',
              child: DataTextValue(
                text: '${species.captureRatePercent.toStringAsFixed(2)}%',
              ),
            ),
          ];
        } else {
          children = [const DataTextValue(text: 'Loading...')];
        }

        return DataSection(
          title: 'Species Data',
          color: pokemon.types.first.color,
          children: children,
        );
      },
    );
  }
}
