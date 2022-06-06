import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/move/move.dart';
import 'package:pokedex_app/models/pokemon/type_parser.dart';
import 'package:pokedex_app/repos/moves_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex_app/screens/pokemons/widgets/pokemon_card.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class MoveDetailsScreen extends StatelessWidget {
  static const routeName = 'move-details';

  final String moveName;

  const MoveDetailsScreen({
    Key? key,
    required this.moveName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: FutureBuilder<Move>(
        future: context.read<MovesRepo>().getMove(moveName),
        builder: (context, snapshot) {
          final Widget body;
          PreferredSizeWidget? tabBar;

          if (snapshot.hasError) {
            body = Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final move = snapshot.data!;

            tabBar = const TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.only(bottom: 4.0),
              tabs: [
                Tab(text: 'About'),
                Tab(text: 'Pokemons'),
              ],
            );

            body = TabBarView(
              children: [
                _AboutTab(move: move),
                _PokemonsTab(move: move),
              ],
            );
          } else {
            body = const Center(child: PokeballLoadingIndicator());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(moveName.hyphenToPascalWord()),
              backgroundColor: snapshot.hasData
                  ? TypeParser.getColorByName(snapshot.data!.type.name)
                  : CategoryColors.moves,
              bottom: tabBar,
            ),
            body: body,
          );
        },
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  final Move move;

  const _AboutTab({
    Key? key,
    required this.move,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width * 0.75;
    return Stack(
      children: [
        Positioned(
          top: iconSize * 0.3,
          right: -iconSize * 0.25,
          child: Icon(
            TypeParser.getIconByName(move.type.name),
            color: TypeParser.getColorByName(move.type.name).withOpacity(0.3),
            size: iconSize,
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(kPaddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(move.flavorTextDefault.text.replaceNewLineTo()),
              const SizedBox(height: 8.0),
              _Group(
                labelText: 'Effect',
                child: Text(move.effectEntryDefault.effect),
              ),
              _Group(
                labelText: 'Type',
                child: Text(move.type.name.capitalize()),
              ),
              _Group(
                labelText: 'Accuracy',
                child: Text(
                  move.accuracy != null
                      ? '${move.accuracy}%'
                      : 'Unknown', // or 100%? need more info what null can mean in this case
                ),
              ),
              _Group(
                labelText: 'Effect chance',
                child: Text(
                  move.effectChance != null
                      ? '${move.effectChance}%'
                      : 'Unknown', // or 100%? need more info what null can mean in this case
                ),
              ),
              _Group(
                labelText: 'Power Points',
                child: Text('${move.pp}'),
              ),
              _Group(
                labelText: 'Battle Execuiton Priority',
                child: Text('${move.priority}'),
              ),
              _Group(
                labelText: 'Base Power',
                child: Text('${move.power ?? 0}'),
              ),
              _Group(
                labelText: 'Damage Class',
                child: Text(move.damageClass.name.hyphenToPascalWord()),
              ),
              _Group(
                labelText: 'Target',
                child: Text(move.target.name.hyphenToPascalWord()),
              ),
              _Group(
                labelText: 'Introduced in',
                // TODO: Change to some "beautiful" adapter for generations
                child: Text(move.generation.name.hyphenToPascalWord()),
              ),
              if (move.statChanges.isNotEmpty) ...[
                _Group(
                  labelText: 'Stat Changes',
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final sc in move.statChanges)
                        Text(
                          '${sc.stat.name.hyphenToPascalWord()}: ${sc.change}',
                        ),
                    ],
                  ),
                ),
              ],
              _Group(
                labelText: 'Category',
                child: Text(move.meta.category.name.hyphenToPascalWord()),
              ),
              _Group(
                labelText: 'Ailment',
                child: Text(move.meta.ailment.name.hyphenToPascalWord()),
              ),
              _Group(
                labelText: 'Ailment Chance',
                child: Text('${move.meta.ailmentChance}%'),
              ),
              _Group(
                labelText: 'Crit. Rate',
                child: Text('${move.meta.critRate}%'),
              ),
              _Group(
                labelText: 'Drain',
                child: Text('${move.meta.drain}%'),
              ),
              _Group(
                labelText: 'Flinch Chance',
                child: Text('${move.meta.flinchChance}%'),
              ),
              _Group(
                labelText: 'Healing',
                child: Text('${move.meta.healing}%'),
              ),
              _Group(
                labelText: 'Stat Affect Chance',
                child: Text('${move.meta.statChance}%'),
              ),
              _Group(
                labelText: 'Effect Continuity',
                child:
                    Text('${move.meta.minTurns} - ${move.meta.maxTurns} turns'),
              ),
              _Group(
                labelText: 'Number of Hits',
                child: Text('${move.meta.minHits} - ${move.meta.maxHits} hits'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PokemonsTab extends StatelessWidget {
  final Move move;

  const _PokemonsTab({
    Key? key,
    required this.move,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(kPaddingDefault),
      itemCount: move.learnedByPokemon.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemBuilder: (_, index) {
        final pokeRes = move.learnedByPokemon[index];
        return PokemonCard(
          pokemonName: pokeRes.name,
          onTap: () => context.pushNamed(
            PokemonDetailsScreen.routeName,
            params: {'name': pokeRes.name},
          ),
        );
      },
    );
  }
}

class _Group extends StatelessWidget {
  static const _labelStyle = TextStyle(fontWeight: FontWeight.bold);

  final String labelText;
  final Widget child;

  const _Group({
    Key? key,
    required this.labelText,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: _labelStyle),
        const SizedBox(height: 4.0),
        child,
        const SizedBox(height: 8.0),
      ],
    );
  }
}
