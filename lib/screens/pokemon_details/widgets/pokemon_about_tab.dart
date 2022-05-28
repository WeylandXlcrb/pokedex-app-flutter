import 'package:flutter/material.dart';

import 'package:pokedex_app/screens/pokemon_details/widgets/about_tab/types_section.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/about_tab/abilities_section.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/about_tab/about_data_section.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/about_tab/held_items_section.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/about_tab/species_data_section.dart';

const _sectionSpacing = SliverToBoxAdapter(child: SizedBox(height: 16.0));
const _edgePadding = SliverToBoxAdapter(child: SizedBox(height: 32.0));

class PokemonAboutTab extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonAboutTab({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Required to not allow body scroll under sliver header
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        _edgePadding,
        PokedexDataSection(pokemon: pokemon),
        _sectionSpacing,
        SpeciesDataSection(pokemon: pokemon),
        _sectionSpacing,
        AbilitiesSection(pokemon: pokemon),
        _sectionSpacing,
        HeldItemsSection(pokemon: pokemon),
        _sectionSpacing,
        TypesSection(pokemon: pokemon),
        _edgePadding,
      ],
    );
  }
}
