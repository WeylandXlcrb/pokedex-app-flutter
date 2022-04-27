import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/category.dart';
import 'package:pokedex_app/screens/home/components/category_card.dart';

class HomeScreen extends StatelessWidget {
  static const _pokeballFraction = 0.6;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size.width;
    final topPadding = mediaQuery.padding.top;
    final pokeballSize = screenSize * _pokeballFraction;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(

      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: topPadding * 1.2,
            right: -pokeballSize * 0.20,
            width: pokeballSize,
            height: pokeballSize,
            child: Transform.rotate(
              angle: -math.pi / 12,
              child: Image.asset(
                AssetImages.pokeball,
                color: Colors.black.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: mediaQuery.size.height * 0.08),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kPaddingDefault,
                      vertical: kPaddingDefault * 2,
                    ),
                    child: Text(
                      'What Pokemon are \nyou looking for?',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingDefault,
                  ),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 16 / 8,
                    children: [
                      for (final category in Category.data)
                        CategoryCard(category: category),
                    ],
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
