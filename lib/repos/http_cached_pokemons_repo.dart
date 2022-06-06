import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/pokemon/ability.dart';
import 'package:pokedex_app/models/pokemon/evolution_chain.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species.dart';
import 'package:pokedex_app/models/pokemon/type.dart';
import 'package:pokedex_app/repos/http_cached_repo.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/requests/pokemons/ability_request.dart';
import 'package:pokedex_app/requests/pokemons/evolution_chain_request.dart';
import 'package:pokedex_app/requests/pokemons/pokemon_list_request.dart';
import 'package:pokedex_app/requests/pokemons/pokemon_request.dart';
import 'package:pokedex_app/requests/pokemons/pokemon_species_request.dart';
import 'package:pokedex_app/requests/pokemons/type_request.dart';
import 'package:pokedex_app/services/pokemons_cache.dart';

class HttpCachedPokemonsRepo extends HttpCachedRepo implements PokemonsRepo {
  final _cache = PokemonsCache();

  @override
  Future<NamedAPIResourceList> getPokemonList({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) async =>
      getCachedData(
        serializer: NamedAPIResourceList.serializer,
        createRequest: () => PokemonListRequest(page: page, limit: limit),
        getCachedData: () => _cache.getPokemonList(page: page, limit: limit),
        setCachedData: (data) =>
            _cache.setPokemonList(page: page, limit: limit, data: data),
      );

  @override
  Future<Pokemon> getPokemonByName(String name) async => getCachedData(
        serializer: Pokemon.serializer,
        createRequest: () => PokemonRequest(pokemonName: name),
        getCachedData: () => _cache.getPokemonByName(name: name),
        setCachedData: (data) =>
            _cache.setPokemonByName(name: name, data: data),
      );

  @override
  Future<PokemonSpecies> getSpecies(int id) async => getCachedData(
        serializer: PokemonSpecies.serializer,
        createRequest: () => PokemonSpeciesRequest(id: id),
        getCachedData: () => _cache.getSpecies(id),
        setCachedData: (data) => _cache.setSpecies(id: id, data: data),
      );

  @override
  Future<Ability> getAbility(String name) async => getCachedData(
        serializer: Ability.serializer,
        createRequest: () => AbilityRequest(name: name),
        getCachedData: () => _cache.getAbility(name),
        setCachedData: (data) => _cache.setAbility(name: name, data: data),
      );

  @override
  Future<TypeP> getType(String name) async => getCachedData(
        serializer: TypeP.serializer,
        createRequest: () => TypeRequest(name: name),
        getCachedData: () => _cache.getType(name),
        setCachedData: (data) => _cache.setType(name: name, data: data),
      );

  @override
  Future<EvolutionChain> getEvolutionChain(int speciesId) async {
    final species = await getSpecies(speciesId);

    return getCachedData(
      serializer: EvolutionChain.serializer,
      createRequest: () => EvolutionChainRequest(id: species.evolutionChainId),
      getCachedData: () => _cache.getEvolutionChain(species.evolutionChainId),
      setCachedData: (data) =>
          _cache.setEvolutionChain(id: species.evolutionChainId, data: data),
    );
  }
}
