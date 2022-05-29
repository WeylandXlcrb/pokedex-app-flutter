import 'package:flutter/material.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/overlap_injector_scroll_view.dart';

class PokemonMovesTab extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonMovesTab({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlapInjectorScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, idx) {
              final pokeMove = pokemon.moves[idx];
              // TODO: make links to actual move page
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(pokeMove.move.name.hyphenToPascalWord()),
              );
            },
            childCount: pokemon.moves.length,
          ),
        ),
      ],
    );
  }
}
