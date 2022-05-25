import 'package:flutter/material.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon_ability.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/pokemon/ability.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';
import 'package:pokedex_app/widgets/type_badge.dart';

const _sectionSpacing = SliverToBoxAdapter(child: SizedBox(height: 16.0));
const _edgePadding = SliverPadding(padding: EdgeInsets.only(top: 32.0));

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
        _PokedexDataSection(pokemon: pokemon),
        _sectionSpacing,
        _SpeciesDataSection(pokemon: pokemon),
        _sectionSpacing,
        _AbilitiesSection(pokemon: pokemon),
        _sectionSpacing,
        _HeldItemsSection(pokemon: pokemon),
        _sectionSpacing,
        _TypesSection(pokemon: pokemon),
        _edgePadding,
      ],
    );
  }
}

class _TypesSection extends StatelessWidget {
  const _TypesSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Types',
      color: pokemon.types.first.color,
      children: [
        for (final type in pokemon.types)
          // TODO: replace with detailed info
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TypeBadge(type: type),
          )
      ],
    );
  }
}

class _HeldItemsSection extends StatelessWidget {
  const _HeldItemsSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return _Section(
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
            child: _DataTextValue(text: 'No Data Available...'),
          )
      ],
    );
  }
}

class _AbilitiesSection extends StatelessWidget {
  final Pokemon pokemon;

  const _AbilitiesSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Section(
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
      title: Text(pokeAbility.ability.name.capitalize()),
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
                      '"${ability.flavorTextDefault.text}"',
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

class _PokedexDataSection extends StatelessWidget {
  const _PokedexDataSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Pokedex Data',
      color: pokemon.types.first.color,
      children: [
        _DataRow(
          labelText: 'Height',
          child: _DataTextValue(text: '${pokemon.heightInCm}cm.'),
        ),
        _DataRow(
          labelText: 'Weight',
          child: _DataTextValue(text: '${pokemon.weightInKg}kg.'),
        ),
        _DataRow(
          labelText: 'Base Experience',
          child: _DataTextValue(text: '${pokemon.baseExperience}'),
        ),
      ],
    );
  }
}

class _SpeciesDataSection extends StatelessWidget {
  final Pokemon pokemon;

  const _SpeciesDataSection({
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
            _DataRow(
              labelText: 'Genus',
              child: _DataTextValue(text: species.genusDefault.genus),
            ),
            _DataRow(
              labelText: 'Base Happiness',
              child: _DataTextValue(text: '${species.baseHappiness}'),
            ),
            if (species.isBaby) const _DataTextValue(text: 'Baby Pokemon'),
            if (species.isLegendary) const _DataTextValue(text: 'Legendary'),
            if (species.isMythical) const _DataTextValue(text: 'Mythical'),
            _DataRow(
              labelText: 'Gender Rate',
              child: species.isGenderless
                  ? const _DataTextValue(text: 'Genderless')
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
              _DataRow(
                labelText: 'Gender visual difference',
                child: _DataTextValue(
                  text: species.hasGenderDifferences ? 'Differ' : 'Identical',
                ),
              ),
            _DataRow(
              labelText: 'Capture Rate',
              child: _DataTextValue(
                text: '${species.captureRatePercent.toStringAsFixed(2)}%',
              ),
            ),
          ];
        } else {
          children = [const _DataTextValue(text: 'Loading...')];
        }

        return _Section(
          title: 'Species Data',
          color: pokemon.types.first.color,
          children: children,
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  /// Heading text
  final String title;

  /// Section's heading color
  final Color color;

  /// List of widgets inside of a section
  final List<Widget> children;

  /// Optional subtitle for section
  final String? subtitle;

  const _Section({
    Key? key,
    required this.title,
    required this.color,
    required this.children,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _DataHeading(
              text: title,
              color: color,
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: _DataTextValue(text: subtitle!),
              ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DataHeading extends StatelessWidget {
  final String text;
  final Color color;

  const _DataHeading({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String labelText;
  final Widget child;

  const _DataRow({
    Key? key,
    required this.labelText,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              labelText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _DataTextValue extends StatelessWidget {
  final String text;

  const _DataTextValue({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Color(0xFF666666)),
    );
  }
}
