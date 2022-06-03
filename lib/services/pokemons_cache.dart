import 'package:pokedex_app/services/cache.dart';

class PokemonsCache extends TimeBasedCache {
  static final _instance = PokemonsCache._();

  PokemonsCache._();

  factory PokemonsCache() => _instance;

  @override
  final boxName = 'pokemons';

  @override
  Duration get cacheDuration => const Duration(days: 30);

  String _getPokemonListCacheKey(int page, int limit) =>
      'Pokemons_page-${page}_limit-$limit';

  String _getPokemonCacheKey(String name) => 'Pokemon-$name';

  String _getSpeciesCacheKey(int id) => 'Species-$id';

  String _getAbilityCacheKey(String name) => 'Ability-$name';

  String _getTypeCacheKey(String name) => 'Type-$name';

  String _getEvolutionChainCacheKey(int id) => 'EvoChain-$id';

  Future<CachedData<String>?> getPokemonList(
          {required int page, required int limit}) =>
      get(_getPokemonListCacheKey(page, limit));

  Future<void> setPokemonList({
    required int page,
    required int limit,
    required String data,
  }) =>
      put(_getPokemonListCacheKey(page, limit), data);

  Future<CachedData<String>?> getPokemonByName({required String name}) async =>
      get(_getPokemonCacheKey(name));

  Future<void> setPokemonByName({required String name, required String data}) =>
      put(_getPokemonCacheKey(name), data);

  Future<CachedData<String>?> getSpecies(int id) async =>
      get(_getSpeciesCacheKey(id));

  Future<void> setSpecies({required int id, required String data}) =>
      put(_getSpeciesCacheKey(id), data);

  Future<CachedData<String>?> getAbility(String name) async =>
      get(_getAbilityCacheKey(name));

  Future<void> setAbility({required String name, required String data}) =>
      put(_getAbilityCacheKey(name), data);

  Future<CachedData<String>?> getType(String name) async =>
      get(_getTypeCacheKey(name));

  Future<void> setType({required String name, required String data}) =>
      put(_getTypeCacheKey(name), data);

  Future<CachedData<String>?> getEvolutionChain(int id) async =>
      get(_getEvolutionChainCacheKey(id));

  Future<void> setEvolutionChain({required int id, required String data}) =>
      put(_getEvolutionChainCacheKey(id), data);
}
