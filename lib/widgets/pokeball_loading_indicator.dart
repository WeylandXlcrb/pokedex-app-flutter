import 'package:flutter/material.dart';
import 'package:pokedex_app/asset_images.dart';

class PokeballLoadingIndicator extends StatelessWidget {
  const PokeballLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetImages.pokeballAnimated,
      width: 75,
      height: 75,
    );
  }
}
