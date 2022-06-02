import 'package:pokedex_app/services/cache.dart';

class MovesCache extends TimeBasedCache {
  static final _instance = MovesCache._();

  MovesCache._();

  factory MovesCache() => _instance;

  @override
  final boxName = 'moves';

  @override
  Duration get cacheDuration => const Duration(days: 30);

  String _getMovesListCacheKey(int page, int limit) =>
      'Moves-page-${page}_limit_$limit';

  String _getMoveCacheKey(String name) => 'Move-$name';

  Future<CachedData<String>?> getMoveList({
    required int page,
    required int limit,
  }) =>
      get(_getMovesListCacheKey(page, limit));

  Future<void> setMoveList({
    required int page,
    required int limit,
    required String data,
  }) =>
      put(_getMovesListCacheKey(page, limit), data);

  Future<CachedData<String>?> getMove(String name) =>
      get(_getMoveCacheKey(name));

  Future<void> setMove({required String name, required String data}) =>
      put(_getMoveCacheKey(name), data);
}
