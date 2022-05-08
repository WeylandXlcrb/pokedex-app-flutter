import 'package:pokedex_app/services/cache.dart';

class PokemonsCache extends TimeBasedCache {
  static final _instance = PokemonsCache._();

  PokemonsCache._();

  factory PokemonsCache() => _instance;

  @override
  final boxName = 'pokemons';

  @override
  Duration get cacheDuration => const Duration(days: 7);

  String _getPokemonListCacheKey(int page, int limit) =>
      'Pokemons_page-${page}_limit-$limit';

  Future<CachedData<String>?> getPokemonList({
    required int page,
    required int limit,
  }) async =>
      get<String>(_getPokemonListCacheKey(page, limit));

  Future<void> setPokemonList({
    required int page,
    required int limit,
    required String data,
  }) async =>
      put(_getPokemonListCacheKey(page, limit), data);
}
