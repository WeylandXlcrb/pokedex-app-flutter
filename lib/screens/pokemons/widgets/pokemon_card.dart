import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/widgets/pokemon_image.dart';
import 'package:pokedex_app/widgets/type_badge.dart';

class PokemonCard extends StatefulWidget {
  final String pokemonName;
  final VoidCallback? onTap;

  const PokemonCard({
    Key? key,
    required this.pokemonName,
    this.onTap,
  }) : super(key: key);

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  static const _cardHeight = 110.0;
  static const _transitionDuration = Duration(milliseconds: 500);
  Pokemon? _pokemon;
  bool _hasError = false;

  Iterable<PokemonType> get _typesCapped => _pokemon?.typesCapped() ?? [];

  @override
  void initState() {
    super.initState();
    _fetchPokemon();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _fetchPokemon() async {
    try {
      final poke = await context
          .read<PokemonsRepo>()
          .getPokemonByName(widget.pokemonName);
      setState(() => _pokemon = poke);
    } catch (err) {
      print(err.toString());
      setState(() => _hasError = true);
    }
  }

  Gradient _buildGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [0.3, 2],
      colors: [
        if (_typesCapped.length < kDefaultTypeLengthCap)
          ...List.generate(
            2,
            (_) => _typesCapped.isEmpty
                ? TypeColors.unknown
                : _typesCapped.first.dimColor,
          )
        else ...[
          for (final type in _typesCapped) type.dimColor,
        ]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const pokeballSize = _cardHeight * 1.5;
    const imageSize = _cardHeight * 1.2;

    return SizedBox(
      height: _cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: _transitionDuration,
            width: double.infinity,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: _buildGradient(),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: (_pokemon?.types.first.color ?? TypeColors.unknown)
                      .withOpacity(0.3),
                  offset: const Offset(0, 6),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (_, constraints) => Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: constraints.maxWidth * 0.25,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) => LinearGradient(
                        colors: [Colors.white30, Colors.white.withOpacity(0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: Image.asset(
                        AssetImages.dotted,
                        width: constraints.maxWidth * 0.23,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -pokeballSize * 0.1,
                    right: -pokeballSize * 0.1,
                    child: Image.asset(
                      AssetImages.pokeball,
                      width: pokeballSize,
                      height: pokeballSize,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kPaddingDefault),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultTextStyle.merge(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                          child: TweenAnimationBuilder<int>(
                            tween: IntTween(begin: 0, end: _pokemon?.id ?? 0),
                            duration: _transitionDuration,
                            builder: (_, id, __) =>
                                Text('#${'$id'.padLeft(3, '0')}'),
                          ),
                        ),
                        DefaultTextStyle.merge(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                          child: AnimatedCrossFade(
                            firstChild: const Text('-------'),
                            secondChild:
                                Text(_pokemon?.name.hyphenToPascalWord() ?? ''),
                            duration: _transitionDuration,
                            crossFadeState: _pokemon != null
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                          ),
                        ),
                        if (_pokemon != null)
                          Row(
                            children: [
                              for (final type in _typesCapped)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: TypeBadge(type: type),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -imageSize * 0.15,
            right: 0,
            child: PokemonImage(
              pokemon: _pokemon,
              duration: _transitionDuration,
              imageSize: imageSize,
              hasError: _hasError,
            ),
          ),
          // Added here only to not increase indentation level, can
          // wrap whole widget as well
          GestureDetector(onTap: _pokemon != null ? widget.onTap : null),
        ],
      ),
    );
  }
}
