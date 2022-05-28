import 'package:flutter/material.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/section_and_data.dart';

class HeldItemsSection extends StatelessWidget {
  const HeldItemsSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DataSection(
      title: 'Held Items',
      subtitle: 'A list of items this Pokémon may be holding when encountered.',
      color: pokemon.types.first.color,
      children: [
        if (pokemon.heldItems.isNotEmpty)
          for (final heldItem in pokemon.heldItems)
            // TODO: normal widget
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(heldItem.item.name),
            )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: DataTextValue(text: 'No Data Available...'),
          )
      ],
    );
  }
}
