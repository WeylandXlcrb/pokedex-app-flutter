import 'package:pokedex_app/services/cache.dart';

class ItemsCache extends TimeBasedCache {
  static final _instance = ItemsCache._();

  ItemsCache._();

  factory ItemsCache() => _instance;

  @override
  final boxName = 'items';

  @override
  Duration get cacheDuration => const Duration(days: 30);

  String _getItemListCacheKey(int page, int limit) =>
      'Items-page-${page}_limit_$limit';

  String _getItemCacheKey(String name) => 'Item-$name';

  Future<CachedData<String>?> getItemList({
    required int page,
    required int limit,
  }) =>
      get(_getItemListCacheKey(page, limit));

  Future<void> setItemList({
    required int page,
    required int limit,
    required String data,
  }) =>
      put(_getItemListCacheKey(page, limit), data);

  Future<CachedData<String>?> getItem(String name) =>
      get(_getItemCacheKey(name));

  Future<void> setItem({required String name, required String data}) =>
      put(_getItemCacheKey(name), data);
}
