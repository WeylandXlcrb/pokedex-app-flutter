import 'package:flutter/material.dart';
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
  static const _cardHeight = 100.0;
  static const _transitionDuration = Duration(milliseconds: 400);
  var _isLoading = true;
  Pokemon? _pokemon;
  bool _hasError = false;

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
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _pokemon == null ? Colors.blueGrey : Colors.lightGreen,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: _pokemon == null
                      ? Colors.blueGrey.withOpacity(0.3)
                      : Colors.lightGreen.withOpacity(0.3),
                  offset: const Offset(0, 8),
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
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kPaddingDefault),
                    child: _hasError
                        ? const Center(
                            child: Text('Error'),
                          )
                        : _pokemon != null
                            ? Center(
                                child: Text(
                                    '${_pokemon!.name}-${_pokemon!.hashedId}'),
                              )
                            : const Center(
                                child: Text('LOADING...'),
                              ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -imageSize * 0.125,
            right: 0,
            child: AnimatedCrossFade(
              firstChild: _isLoading
                  ? _placeholderImage
                  : CachedNetworkImage(
                      imageUrl: _pokemon!.sprites.frontDefault,
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
