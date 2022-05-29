import 'package:flutter/material.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/overlap_injector_scroll_view.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/stats_tab/base_stats_section.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/stats_tab/types_section.dart';

class PokemonStatsTab extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonStatsTab({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlapInjectorScrollView(
      slivers: [
        BaseStatsSection(pokemon: pokemon),
        const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
        TypesSection(pokemon: pokemon),
      ],
    );
  }
}
