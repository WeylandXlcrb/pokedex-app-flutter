import 'package:flutter/painting.dart';
import 'package:pokedex_app/extensions/string.dart';

enum CategoryType {
  pokemons,
  locations,
  items,
  moves,
  evolutions,
}

class Category {
  final CategoryType type;
  final Color color;

  const Category({
    required this.type,
    required this.color,
  });

  String get name => type.name.capitalize();

  static const data = [
    Category(
      type: CategoryType.pokemons,
      color: Color.fromRGBO(225, 73, 67, 1),
    ),
    Category(
      type: CategoryType.moves,
      color: Color.fromRGBO(230, 162, 70, 1),
    ),
    Category(
      type: CategoryType.evolutions,
      color: Color.fromRGBO(90, 176, 137, 1),
    ),
    Category(
      type: CategoryType.locations,
      color: Color.fromRGBO(107, 173, 219, 1),
    ),
    Category(
      type: CategoryType.items,
      color: Color.fromRGBO(148, 72, 227, 1.0),
    ),
  ];
}
