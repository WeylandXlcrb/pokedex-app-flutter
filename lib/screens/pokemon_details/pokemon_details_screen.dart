import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
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

class _ScreenBody extends StatelessWidget {
  final Pokemon pokemon;

  const _ScreenBody({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: pokemon.types.first.dimColor),
        ),
        CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _PokemonSliverAppBarDelegate(
                topPadding: MediaQuery.of(context).padding.top,
                pokemon: pokemon,
              ),
            )
          ],
        )
      ],
    );
  }
}

class _PokemonSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double topPadding;
  final Pokemon pokemon;

  const _PokemonSliverAppBarDelegate({
    required this.topPadding,
    required this.pokemon,
  });

  @override
  double get maxExtent => 400.0;

  @override
  double get minExtent => kToolbarHeight + topPadding;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) =>
      minExtent != old.minExtent ||
      maxExtent != old.maxExtent ||
      snapConfiguration != old.snapConfiguration;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: topPadding + 20),
          child: FittedBox(
            fit: BoxFit.none,
            alignment: Alignment.center,
            child: ShaderMask(
              shaderCallback: (rect) => LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.75],
              ).createShader(rect),
              child: Text(
                pokemon.name.toUpperCase(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.25,
                  foreground: Paint()
                    ..color = Colors.white
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                ),
              ),
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Opacity(
            opacity: shrinkOffset / maxExtent,
            child: Text(pokemon.name.capitalize()),
          ),
        ),
      ],
    );
  }
}
