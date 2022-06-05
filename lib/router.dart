import 'package:go_router/go_router.dart';

import 'package:pokedex_app/screens/generations/generations_screen.dart';
import 'package:pokedex_app/screens/home/home_screen.dart';
import 'package:pokedex_app/screens/items/items_screen.dart';
import 'package:pokedex_app/screens/location_details/location_details_screen.dart';
import 'package:pokedex_app/screens/locations/locations_screen.dart';
import 'package:pokedex_app/screens/move_details/move_details_screen.dart';
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
          routes: [
            GoRoute(
              path: ':name',
              name: MoveDetailsScreen.routeName,
              builder: (context, state) => MoveDetailsScreen(
                moveName: state.params['name']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'generations',
          name: GenerationsScreen.routeName,
          builder: (context, state) => const GenerationsScreen(),
        ),
        GoRoute(
          path: 'locations',
          name: LocationsScreen.routeName,
          builder: (context, state) => const LocationsScreen(),
          routes: [
            GoRoute(
              path: ':name',
              name: LocationDetailsScreen.routeName,
              builder: (context, state) => LocationDetailsScreen(
                locationName: state.params['name']!,
              ),
            ),
          ],
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
