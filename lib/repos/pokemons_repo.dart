import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';

abstract class PokemonsRepo {
  Future<NamedAPIResourceList> getPokemonList({int page, int limit});

  Future<Pokemon> getPokemonByName(String name);
}
