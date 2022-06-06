import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/location/location_area.dart';
import 'package:pokedex_app/models/location/pokemon_encounter.dart';
import 'package:pokedex_app/models/version_encounter_detail.dart';
import 'package:pokedex_app/repos/locations_repo.dart';
import 'package:pokedex_app/screens/pokemons/widgets/pokemon_card.dart';
import 'package:pokedex_app/screens/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class AreaDetailsScreen extends StatelessWidget {
  static const routeName = 'area-details';
  final String areaName;

  const AreaDetailsScreen({
    Key? key,
    required this.areaName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(areaName.hyphenToPascalWord()),
        backgroundColor: CategoryColors.locations,
      ),
      body: FutureBuilder<LocationArea>(
        future: context.read<LocationsRepo>().getLocationArea(areaName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return _LocationAreaBody(area: snapshot.data!);
          }

          return const Center(child: PokeballLoadingIndicator());
        },
      ),
    );
  }
}

class _LocationAreaBody extends StatelessWidget {
  final LocationArea area;

  const _LocationAreaBody({
    Key? key,
    required this.area,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(kPaddingDefault),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Location:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4.0),
                    Text(area.location.name.hyphenToPascalWord()),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Encounters',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _PokemonEncounterCard(
                pokeEncounter: area.pokemonEncounters[index],
              ),
              childCount: area.pokemonEncounters.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _PokemonEncounterCard extends StatelessWidget {
  final PokemonEncounter pokeEncounter;

  const _PokemonEncounterCard({
    Key? key,
    required this.pokeEncounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PokemonCard(
          pokemonName: pokeEncounter.pokemon.name,
          onTap: () => context.pushNamed(
            PokemonDetailsScreen.routeName,
            params: {'name': pokeEncounter.pokemon.name},
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            for (final versionDetail in pokeEncounter.versionDetails)
              _VersionDetailCard(versionDetail: versionDetail),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class _VersionDetailCard extends StatelessWidget {
  static const _firstLevelIndent = 8.0;

  final VersionEncounterDetail versionDetail;

  const _VersionDetailCard({
    Key? key,
    required this.versionDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DataRow(
            label: 'Version',
            value: versionDetail.version.name.hyphenToPascalWord(),
          ),
          _DataRow(
            label: 'Max Chance',
            value: '${versionDetail.maxChance}%',
          ),
          for (final encounter in versionDetail.encounterDetails) ...[
            const SizedBox(height: 4.0),
            _DataRow(
              label: 'Method',
              value: encounter.method.name.hyphenToPascalWord(),
            ),
            _DataRow(
              indent: _firstLevelIndent,
              label: 'Chance',
              value: '${encounter.chance}%',
            ),
            _DataRow(
              indent: _firstLevelIndent,
              label: 'Levels',
              value: '${encounter.minLevel} - ${encounter.maxLevel}',
            ),
            if (encounter.conditionValues.isNotEmpty) ...[
              const SizedBox(height: 4.0),
              const _DataRow(
                indent: _firstLevelIndent,
                label: 'Conditions',
                value: '',
              ),
              for (final condition in encounter.conditionValues)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text('- ${condition.name.hyphenToPascalWord()}'),
                ),
            ],
          ],
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final String value;
  final double indent;

  const _DataRow({
    Key? key,
    required this.label,
    required this.value,
    this.indent = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
