import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/ability.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_ability.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/section_and_data.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class AbilitiesSection extends StatelessWidget {
  final Pokemon pokemon;

  const AbilitiesSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataSection(
      title: 'Abilities',
      subtitle: 'An Ability provides a passive effect in battle or in '
          'the overworld. Individual Pokémon may have only one '
          'Ability at a time.',
      color: pokemon.types.first.color,
      children: [
        for (final pokeAbility in pokemon.abilities)
          _AbilityTile(
            pokeAbility: pokeAbility,
            color: pokemon.types.first.color,
          ),
      ],
    );
  }
}

class _AbilityTile extends StatelessWidget {
  final PokemonAbility pokeAbility;
  final Color color;

  const _AbilityTile({
    Key? key,
    required this.pokeAbility,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // If false, request is send only when tile is expanded, but it
      // sends every time when expanded, if true, it sends all requests
      // immediately, but only once
      // maintainState: true,
      title: Text(pokeAbility.ability.name.hyphenToPascalWord()),
      collapsedIconColor: color,
      iconColor: Colors.grey,
      textColor: Colors.black,
      tilePadding: EdgeInsets.zero,
      children: [
        FutureBuilder<Ability>(
          future:
              context.read<PokemonsRepo>().getAbility(pokeAbility.ability.name),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final ability = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (pokeAbility.isHidden) ...[
                      const Text(
                        'Hidden ability',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                    Text(ability.effectDefault.effect),
                    const SizedBox(height: 8.0),
                    Text(
                      '"${ability.flavorTextDefault.text.replaceNewLineTo()}"',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: PokeballLoadingIndicator());
          },
        ),
      ],
    );
  }
}
