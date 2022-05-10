import 'package:flutter/material.dart';
import 'package:pokedex_app/constants.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';

class PokemonCard extends StatelessWidget {
  final String pokemonName;

  const PokemonCard({
    Key? key,
    required this.pokemonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: try crossfade transition
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kPaddingDefault),
            child: FutureBuilder(
              future: context.read<PokemonsRepo>().getPokemonByName(pokemonName),
              builder: (context, AsyncSnapshot<Pokemon> snapshot) {
                if (snapshot.hasError) {
                  // TODO: Normal error state
                  return Center(
                    child: Text(snapshot.error?.toString() ?? 'Error'),
                  );
                }

                if (snapshot.hasData) {
                  final pokemon = snapshot.data!;

                  return Center(
                    child: Text('${pokemon.name}-${pokemon.hashedId}'),
                  );
                }

                // TODO add placeholder loader
                return const Center(
                  child: Text('LOADING...'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
