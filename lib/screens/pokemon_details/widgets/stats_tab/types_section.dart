import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';
import 'package:pokedex_app/models/pokemon/type.dart';
import 'package:pokedex_app/models/pokemon/type_parser.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/section_and_data.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class TypesSection extends StatelessWidget {
  const TypesSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DataSection(
      title: 'Types',
      color: pokemon.types.first.color,
      children: [
        GridView.builder(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pokemon.types.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemBuilder: (_, idx) => _TypeCard(type: pokemon.types[idx]),
        ),
      ],
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    Key? key,
    required this.type,
  }) : super(key: key);

  final PokemonType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: type.color,
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (_, constraints) {
          final iconSize = constraints.maxWidth * 0.55;

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: -iconSize * 0.1,
                top: -iconSize * 0.065,
                child: Icon(
                  type.icon,
                  size: iconSize,
                  color: Colors.white24,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    type.name.capitalize(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Placed here only not to increase indent level
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    isScrollControlled: true,
                    builder: (_) => _TypeModalSheet(pokeType: type),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TypeModalSheet extends StatelessWidget {
  static const _spacer = SizedBox(height: 8.0);
  static const _miniSpacer = SizedBox(height: 4.0);
  static const _headingStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  final PokemonType pokeType;

  const _TypeModalSheet({
    Key? key,
    required this.pokeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              pokeType.icon,
              color: pokeType.color.withOpacity(0.3),
              size: MediaQuery.of(context).size.width * 0.6,
            ),
            SingleChildScrollView(
              child: FutureBuilder<TypeP>(
                future: context.read<PokemonsRepo>().getType(pokeType.name),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    final type = snapshot.data!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          type.name.capitalize(),
                          style: TextStyle(
                            color: type.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                          ),
                        ),
                        PokeDataRow(
                          labelText: 'Damage Class',
                          child: DataTextValue(
                            text: type.moveDamageClass?.name.capitalize() ??
                                'Unknown',
                          ),
                        ),
                        if (type.damageRelations.noDamageTo.isNotEmpty) ...[
                          const Text('No Damage To', style: _headingStyle),
                          _miniSpacer,
                          _TypeBadgeWrap(
                            types: type.damageRelations.noDamageTo,
                          ),
                          _spacer,
                        ],
                        if (type.damageRelations.halfDamageTo.isNotEmpty) ...[
                          const Text('Half Damage To', style: _headingStyle),
                          _miniSpacer,
                          _TypeBadgeWrap(
                            types: type.damageRelations.halfDamageTo,
                          ),
                          _spacer,
                        ],
                        if (type.damageRelations.doubleDamageTo.isNotEmpty) ...[
                          const Text('Double Damage To', style: _headingStyle),
                          _miniSpacer,
                          _TypeBadgeWrap(
                            types: type.damageRelations.doubleDamageTo,
                          ),
                          _spacer,
                        ],
                        if (type.damageRelations.noDamageFrom.isNotEmpty) ...[
                          const Text('No Damage From', style: _headingStyle),
                          _miniSpacer,
                          _TypeBadgeWrap(
                            types: type.damageRelations.noDamageFrom,
                          ),
                          _spacer,
                        ],
                        if (type.damageRelations.halfDamageFrom.isNotEmpty) ...[
                          const Text('Half Damage From', style: _headingStyle),
                          _miniSpacer,
                          _TypeBadgeWrap(
                            types: type.damageRelations.halfDamageFrom,
                          ),
                          _spacer,
                        ],
                        if (type
                            .damageRelations.doubleDamageFrom.isNotEmpty) ...[
                          const Text(
                            'Double Damage From',
                            style: _headingStyle,
                          ),
                          _miniSpacer,
                          _TypeBadgeWrap(
                            types: type.damageRelations.doubleDamageFrom,
                          ),
                          _spacer,
                        ],
                      ],
                    );
                  }

                  return const Center(child: PokeballLoadingIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TypeBadgeWrap extends StatelessWidget {
  final Iterable<NamedAPIResource> types;

  const _TypeBadgeWrap({
    Key? key,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (final t in types)
          DecoratedBox(
            decoration: BoxDecoration(
              color: TypeParser.getColorByName(t.name),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                TypeParser.getIconByName(t.name),
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
