import 'package:flutter/material.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemons/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class PokemonsScreen extends StatelessWidget {
  static const routeName = 'pokemons';

  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: context.read<PokemonsRepo>().getPokemonList(),
        builder: (context, AsyncSnapshot<NamedAPIResourceList> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error?.toString() ?? 'Произошла ошибка'),
            );
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;

            return ListView.separated(
              padding: const EdgeInsets.all(kPaddingDefault),
              itemCount: data.results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
              itemBuilder: (_, index) =>
                  PokemonCard(pokemonName: data.results[index].name),
            );
          }

          // TODO: Change to custom progress indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
