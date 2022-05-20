import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/widgets/pokemon_image.dart';
import 'package:pokedex_app/widgets/stroke_fade_out_text.dart';
import 'package:pokedex_app/widgets/type_badge.dart';

class PokemonSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  static const _tabBarHeight = 40.0;
  final double topPadding;
  final Pokemon pokemon;
  final TabController tabController;

  const PokemonSliverAppBarDelegate({
    required this.topPadding,
    required this.pokemon,
    required this.tabController,
  });

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => kToolbarHeight + topPadding + _tabBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      minExtent != oldDelegate.minExtent ||
      maxExtent != oldDelegate.maxExtent ||
      snapConfiguration != oldDelegate.snapConfiguration;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final shrinkOpacity = min(1.0, shrinkOffset / (maxExtent - minExtent));
    final extendedOpacity = 1.0 - shrinkOpacity;
    final typesCapped = pokemon.typesCapped();
    final mdSize = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: pokemon.types.first.dimColor,
            gradient: typesCapped.length > 1
                ? LinearGradient(
                    colors: typesCapped.map((t) => t.dimColor).toList(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.45, 1],
                  )
                : null,
          ),
        ),
        Opacity(
          opacity: extendedOpacity,
          child: Padding(
            padding: EdgeInsets.only(top: topPadding + 15),
            child: Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                fit: BoxFit.none,
                alignment: Alignment.center,
                child: StrokeFadeOutText(
                  text: pokemon.name.toUpperCase(),
                  fontSize: mdSize.width * 0.25,
                ),
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
          right: 5,
          bottom: _tabBarHeight + 15,
          child: ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.5],
              colors: [Colors.white24, Colors.white10],
            ).createShader(rect),
            child: Image.asset(
              AssetImages.dotted,
              width: mdSize.width * 0.15,
            ),
          ),
        ),
        Positioned(
          top: topPadding + 70,
          child: Opacity(
            opacity: extendedOpacity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kPaddingDefault * 1.5,
              ),
              child: _PokemonRow(pokemon: pokemon),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: TabBar(
            controller: tabController,
            tabs: const [
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
