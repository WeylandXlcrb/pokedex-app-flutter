import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';

class PokemonImage extends StatelessWidget {
  final Pokemon? pokemon;
  final Duration duration;
  final double? imageSize;
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
    return _Image(
      duration: duration,
      hasError: hasError,
      imageSize: imageSize,
      url: pokemon?.sprites.other.officialArtwork.frontDefault ??
          pokemon?.sprites.frontDefault,
      placeholder: _PlaceholderImage(
        assetName: AssetImages.questionMark,
        imageSize: imageSize,
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  final Item? item;
  final Duration duration;
  final bool hasError;
  final double? imageSize;

  const ItemImage({
    Key? key,
    required this.item,
    required this.duration,
    this.imageSize,
    this.hasError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Image(
      duration: duration,
      hasError: hasError,
      imageSize: imageSize,
      url: item?.sprites.defSprite,
      placeholder: _PlaceholderImage(
        assetName: AssetImages.pokeball,
        imageSize: imageSize,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  /// Image url to load
  final String? url;

  /// Duration for transition between images
  final Duration duration;

  /// Size for image, placeholder and error image will be square sized by
  /// the value, while pokemon's image itself will be restricted only by height
  final double? imageSize;

  /// Whether to show error image or not
  final bool hasError;

  /// Placeholder for image
  final Widget placeholder;

  const _Image({
    Key? key,
    required this.duration,
    required this.hasError,
    required this.placeholder,
    this.imageSize,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorImage = _ErrorImage(imageSize: imageSize);

    return AnimatedCrossFade(
      firstChild: url == null
          ? placeholder
          : CachedNetworkImage(
              imageUrl: url!,
              height: imageSize,
              placeholder: (_, __) => placeholder,
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
  final String assetName;
  final double? imageSize;

  const _PlaceholderImage({
    Key? key,
    required this.assetName,
    this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: imageSize,
      child: Center(
        child: Image.asset(assetName, color: Colors.black26),
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
