import 'package:go_router/go_router.dart';

import 'package:pokedex_app/screens/evolutions/evolutions_screen.dart';
import 'package:pokedex_app/screens/home/home_screen.dart';
import 'package:pokedex_app/screens/items/items_screen.dart';
import 'package:pokedex_app/screens/locations/locations_screen.dart';
import 'package:pokedex_app/screens/moves/moves_screen.dart';
import 'package:pokedex_app/screens/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex_app/screens/pokemons/pokemons_screen.dart';

final appRouter = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'pokemons',
          name: PokemonsScreen.routeName,
          builder: (context, state) => const PokemonsScreen(),
          routes: [
            GoRoute(
              path: ':name',
              name: PokemonDetailsScreen.routeName,
              builder: (context, state) => PokemonDetailsScreen(
                pokemonName: state.params['name']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'moves',
          name: MovesScreen.routeName,
          builder: (context, state) => const MovesScreen(),
        ),
        GoRoute(
          path: 'evolutions',
          name: EvolutionsScreen.routeName,
          builder: (context, state) => const EvolutionsScreen(),
        ),
        GoRoute(
          path: 'locations',
          name: LocationsScreen.routeName,
          builder: (context, state) => const LocationsScreen(),
        ),
        GoRoute(
          path: 'items',
          name: ItemsScreen.routeName,
          builder: (context, state) => const ItemsScreen(),
        ),
      ],
    ),
  ],
);
