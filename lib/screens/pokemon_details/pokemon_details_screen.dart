import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/widgets/pokemon_image.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';
import 'package:pokedex_app/widgets/stroke_fade_out_text.dart';
import 'package:pokedex_app/widgets/type_badge.dart';

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
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
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
  double get maxExtent => 300.0;

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
    final shrinkOpacity = shrinkOffset / maxExtent;
    final extendedOpactity = 1 - shrinkOffset / maxExtent;

    return Stack(
      children: [
        Opacity(
          opacity: extendedOpactity,
          child: Padding(
            padding: EdgeInsets.only(top: topPadding + 15),
            child: FittedBox(
              fit: BoxFit.none,
              alignment: Alignment.center,
              child: StrokeFadeOutText(
                text: pokemon.name.toUpperCase(),
                fontSize: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Opacity(
            opacity: shrinkOpacity,
            child: Text(pokemon.name.capitalize()),
          ),
        ),
        Positioned(
          top: topPadding + 70,
          child: Opacity(
            opacity: extendedOpactity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kPaddingDefault * 1.5,
              ),
              child: _PokemonRow(pokemon: pokemon),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: DefaultTabController(
            length: 3,
            child: TabBar(
              tabs: [
                Tab(text: 'About'),
                Tab(text: 'Stats'),
                Tab(text: 'Evolution'),
              ],
              // TODO: make custom indicator
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
            ),
          ),
        ),
      ],
    );
  }
}

class _PokemonRow extends StatelessWidget {
  static const _imageSize = 130.0;

  final Pokemon pokemon;

  const _PokemonRow({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: _imageSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ShaderMask(
                shaderCallback: (rect) => LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white38,
                  ],
                  end: Alignment.bottomCenter,
                ).createShader(rect),
                child: Image.asset(
                  AssetImages.pokeball,
                  height: _imageSize * 0.9,
                  color: Colors.white,
                ),
              ),
              PokemonImage(
                pokemon: pokemon,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pokemon.hashedId,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pokemon.name.capitalize(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (final type in pokemon.typesCapped())
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: TypeBadge(type: type),
                  ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
