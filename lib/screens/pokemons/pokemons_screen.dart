import 'package:flutter/material.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
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
              itemCount: data.results.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) => ListTile(
                title: Text(data.results[index].name),
                subtitle: Text(data.results[index].url),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
