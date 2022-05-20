import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/pokemon_about_tab.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/pokemon_app_bar_delegate.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/pokemon_evolution_tab.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/pokemon_stats_tab.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class PokemonDetailsScreen extends StatelessWidget {
  static const routeName = 'pokemon-details';

  final String pokemonName;

  const PokemonDetailsScreen({
    Key? key,
    required this.pokemonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Scaffold(
      body: FutureBuilder<Pokemon>(
        future: context.read<PokemonsRepo>().getPokemonByName(pokemonName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text(snapshot.error.toString()),
                  TextButton(
                    onPressed: router.pop,
                    child: const Text('Go Back'),
                  )
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return _ScreenBody(pokemon: snapshot.data!);
          }

          return const Center(child: PokeballLoadingIndicator());
        },
      ),
    );
  }
}

class _ScreenBody extends StatefulWidget {
  final Pokemon pokemon;

  const _ScreenBody({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  State<_ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<_ScreenBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  Pokemon get _pokemon => widget.pokemon;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Find a way to adhere to design
    return NestedScrollView(
      headerSliverBuilder: (context, __) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverPersistentHeader(
            pinned: true,
            delegate: PokemonSliverAppBarDelegate(
              topPadding: MediaQuery.of(context).padding.top,
              pokemon: _pokemon,
              tabController: _tabController,
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          PokemonAboutTab(pokemon: _pokemon),
          const PokemonStatsTab(),
          const PokemonEvolutionTab(),
        ],
      ),
    );
  }
}
