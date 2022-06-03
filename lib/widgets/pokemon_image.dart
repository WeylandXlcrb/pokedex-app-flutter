import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';

class PokemonImage extends StatelessWidget {
  /// Pokemon whose image to load
  final Pokemon? pokemon;

  /// Duration for transition between images
  final Duration duration;

  /// Size for image, placeholder and error image will be square sized by
  /// the value, while pokemon's image itself will be restricted only by height
  final double? imageSize;

  /// Whether to show error image or not
  final bool hasError;

  const PokemonImage({
    Key? key,
    required this.pokemon,
    required this.duration,
    this.imageSize,
    this.hasError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholderImage = _PlaceholderImage(imageSize: imageSize);
    final errorImage = _ErrorImage(imageSize: imageSize);

    final url = pokemon?.sprites.other.officialArtwork.frontDefault ??
        pokemon?.sprites.frontDefault ?? '';

    if (url.isEmpty) {
      return placeholderImage;
    }

    return AnimatedCrossFade(
      firstChild: pokemon == null
          ? placeholderImage
          : CachedNetworkImage(
        imageUrl: url,
        height: imageSize,
        placeholder: (_, __) => placeholderImage,
        errorWidget: (_, __, ___) => errorImage,
        fit: BoxFit.contain,
        fadeInDuration: duration,
      ),
      secondChild: errorImage,
      duration: duration,
      crossFadeState:
      hasError ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  final double? imageSize;

  const _PlaceholderImage({
    Key? key,
    this.imageSize,
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
  final double? imageSize;

  const _ErrorImage({
    Key? key,
    this.imageSize,
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
