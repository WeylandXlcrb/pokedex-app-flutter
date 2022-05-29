import 'package:flutter/material.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/section_and_data.dart';

class BaseStatsSection extends StatelessWidget {
  final Pokemon pokemon;

  const BaseStatsSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = pokemon.types.first.color;

    return DataSection(
      color: color,
      title: 'Base Stats',
      children: [
        for (final stat in pokemon.stats)
          PokeDataRow(
            labelText: stat.name,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: stat.baseStat / 255,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Text('${stat.baseStat}'),
              ],
            ),
          ),
      ],
    );
  }
}
