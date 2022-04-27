import 'package:flutter/material.dart';
import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  List<Color> get _gradientColors => [
        category.color,
        Color.alphaBlend(Colors.black12, category.color),
      ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: _gradientColors,
            ),
            boxShadow: [
              BoxShadow(
                color: category.color.withOpacity(0.25),
                blurRadius: 20,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              Positioned(
                bottom: -constraints.maxHeight * 0.05,
                right: -constraints.maxWidth * 0.02,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) => LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 0.3, 0.7],
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.1),
                      category.color,
                    ],
                  ).createShader(bounds),
                  child: Image.asset(
                    AssetImages.dotted,
                    width: constraints.maxWidth * 0.6,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(kPaddingDefault),
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
