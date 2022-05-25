import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/pokemon/ability.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species.dart';

abstract class PokemonsRepo {
  Future<NamedAPIResourceList> getPokemonList({int page, int limit});

  Future<Pokemon> getPokemonByName(String name);

  Future<PokemonSpecies> getSpeciesByName(String name);

  Future<Ability> getAbility(String name);
}
