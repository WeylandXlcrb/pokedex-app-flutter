import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/screens/move_details/move_details_screen.dart';
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
              return ListTile(
                title: Text(pokeMove.move.name.hyphenToPascalWord()),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14.0),
                onTap: () => context.pushNamed(
                  MoveDetailsScreen.routeName,
                  params: {'name': pokeMove.move.name},
                ),
              );
            },
            childCount: pokemon.moves.length,
          ),
        ),
      ],
    );
  }
}
