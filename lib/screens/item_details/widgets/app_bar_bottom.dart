import 'package:flutter/material.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/widgets/pokemon_image.dart';
import 'package:pokedex_app/widgets/stroke_decoration_text.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  static const _height = 100.0;
  static const _duration = Duration(milliseconds: 400);
  final Item? item;

  const AppBarBottom({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -_height * 0.4,
            right: 16.0,
            child: ShaderMask(
              shaderCallback: (Rect bounds) => LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [0, 0.65],
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.02),
                ],
              ).createShader(bounds),
              child: Image.asset(
                AssetImages.dotted,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
          ),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: item?.id ?? 0),
            duration: _duration,
            builder: (_, id, __) => StrokeDecorationText(
              text: '#${'$id'.padLeft(3, '0')}',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.25,
                letterSpacing: 10,
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemImage(
                  item: item,
                  duration: _duration,
                  imageSize: _height * 0.75,
                ),
                const SizedBox(width: 16.0),
                Text(
                  item?.name.hyphenToPascalWord() ?? '------',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}