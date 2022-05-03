import 'package:flutter/painting.dart';
import 'package:pokedex_app/screens/evolutions/evolutions_screen.dart';
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
      color: Color.fromRGBO(225, 73, 67, 1),
    ),
    Category(
      name: 'Moves',
      routeName: MovesScreen.routeName,
      color: Color.fromRGBO(230, 162, 70, 1),
    ),
    Category(
      name: 'Evolutions',
      routeName: EvolutionsScreen.routeName,
      color: Color.fromRGBO(90, 176, 137, 1),
    ),
    Category(
      name: 'Locations',
      routeName: LocationsScreen.routeName,
      color: Color.fromRGBO(107, 173, 219, 1),
    ),
    Category(
      name: 'Items',
      routeName: ItemsScreen.routeName,
      color: Color.fromRGBO(148, 72, 227, 1.0),
    ),
  ];
}
