import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex_app/screens/pokemons/widgets/pokemon_card.dart';
import 'package:pokedex_app/widgets/paginated_resource_list.dart';

class PokemonsScreen extends StatelessWidget {
  static const routeName = 'pokemons';

  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons'),
        backgroundColor: CategoryColors.pokemons,
      ),
      body: PaginatedResourceList(
        pageFetcher: context.read<PokemonsRepo>().getPokemonList,
        separatorBuilder: (_, __) => const SizedBox(height: 16.0),
        itemBuilder: (_, __, resource) => PokemonCard(
          pokemonName: resource.name,
          onTap: () => context.goNamed(
            PokemonDetailsScreen.routeName,
            params: {'name': resource.name},
          ),
        ),
      ),
    );
  }
}
