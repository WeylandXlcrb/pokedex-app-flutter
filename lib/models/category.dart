import 'package:flutter/painting.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/screens/items/items_screen.dart';
import 'package:pokedex_app/screens/locations/locations_screen.dart';
import 'package:pokedex_app/screens/moves/moves_screen.dart';
import 'package:pokedex_app/screens/pokemons/pokemons_screen.dart';

class Category {
  final String name;
  final String routeName;
  final Color color;

  const Category({
    required this.name,
    required this.routeName,
    required this.color,
  });

  static const data = [
    Category(
      name: 'Pokemons',
      routeName: PokemonsScreen.routeName,
      color: CategoryColors.pokemons,
    ),
    Category(
      name: 'Moves',
      routeName: MovesScreen.routeName,
      color: CategoryColors.moves,
    ),
    Category(
      name: 'Locations',
      routeName: LocationsScreen.routeName,
      color: CategoryColors.locations,
    ),
    Category(
      name: 'Items',
      routeName: ItemsScreen.routeName,
      color: CategoryColors.items,
    ),
  ];
}
