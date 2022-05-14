import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';
import 'package:pokedex_app/widgets/type_badge.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';

class PokemonCard extends StatefulWidget {
  final String pokemonName;

  const PokemonCard({
    Key? key,
    required this.pokemonName,
  }) : super(key: key);

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  static const _cardHeight = 110.0;
  static const _transitionDuration = Duration(milliseconds: 400);
  var _isLoading = true;
  Pokemon? _pokemon;
  bool _hasError = false;

  Iterable<PokemonType> get _pokemonTypesCapped =>
      _pokemon?.types.sublist(0, min(2, _pokemon!.types.length)) ?? [];

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
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Color _dimColor(Color original) => Color.alphaBlend(
        Colors.white70.withOpacity(0.1),
        original,
      );

  Gradient _buildGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [0.3, 2],
      colors: [
        if (_pokemonTypesCapped.length < 2)
          ...List.generate(
            2,
            (_) => _dimColor(_pokemonTypesCapped.isEmpty
                ? Colors.blueGrey
                : _pokemonTypesCapped.first.color),
          )
        else ...[
          for (final type in _pokemonTypesCapped) _dimColor(type.color),
        ]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const pokeballSize = _cardHeight * 1.5;
    const imageSize = _cardHeight * 1.2;
    const _placeholderImage = _PlaceholderImage(imageSize: imageSize);
    const _errorImage = _ErrorImage(imageSize: imageSize);

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
                  color: _pokemon == null
                      ? Colors.blueGrey.withOpacity(0.3)
                      : _pokemon!.types.first.color.withOpacity(0.3),
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
                          child: AnimatedCrossFade(
                            firstChild: const Text('#xxx'),
                            secondChild: Text(_pokemon?.hashedId ?? ''),
                            duration: _transitionDuration,
                            crossFadeState: _pokemon != null
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
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
                                Text(_pokemon?.name.capitalize() ?? ''),
                            duration: _transitionDuration,
                            crossFadeState: _pokemon != null
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                          ),
                        ),
                        if (_pokemon != null)
                          Row(
                            children: [
                              for (final type in _pokemonTypesCapped) ...[
                                TypeBadge(type: type),
                                const SizedBox(width: 4),
                              ]
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
            child: AnimatedCrossFade(
              firstChild: _isLoading
                  ? _placeholderImage
                  : CachedNetworkImage(
                      imageUrl:
                          _pokemon!.sprites.other.officialArtwork.frontDefault,
                      height: imageSize,
                      placeholder: (_, __) => _placeholderImage,
                      errorWidget: (_, __, ___) => _errorImage,
                      fit: BoxFit.contain,
                    ),
              secondChild: _errorImage,
              duration: _transitionDuration,
              crossFadeState: _hasError
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  final double imageSize;

  const _PlaceholderImage({
    Key? key,
    required this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: imageSize,
      child: Center(
        child: Image.asset(
          AssetImages.questionMark,
          color: Colors.black26,
        ),
      ),
    );
  }
}

class _ErrorImage extends StatelessWidget {
  final double imageSize;

  const _ErrorImage({
    Key? key,
    required this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.warning,
      size: imageSize,
      color: Colors.black26,
    );
  }
}
