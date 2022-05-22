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

  String _getSpeciesCacheKey(String name) => 'Species-$name';

  Future<CachedData<String>?> getPokemonList({
    required int page,
    required int limit,
  }) =>
      get(_getPokemonListCacheKey(page, limit));

  Future<void> setPokemonList({
    required int page,
    required int limit,
    required String data,
  }) =>
      put(_getPokemonListCacheKey(page, limit), data);

  Future<CachedData<String>?> getPokemonByName({required String name}) async =>
      get(_getPokemonCacheKey(name));

  Future<void> setPokemonByName({
    required String name,
    required String data,
  }) =>
      put(_getPokemonCacheKey(name), data);

  Future<CachedData<String>?> getSpeciesByName(String name) async =>
      get(_getSpeciesCacheKey(name));

  Future<void> setSpeciesByName({
    required String name,
    required String data,
  }) =>
      put(_getSpeciesCacheKey(name), data);
}
