import 'package:pokedex_app/services/cache.dart';

class LocationsCache extends TimeBasedCache {
  static final _instance = LocationsCache._();

  LocationsCache._();

  factory LocationsCache() => _instance;

  @override
  Duration get cacheDuration => const Duration(days: 30);

  @override
  final boxName = 'locations';

  String _getLocationListCacheKey(int page, int limit) =>
      'Locations-page-${page}_limit_$limit';

  Future<CachedData<String>?> getLocationList({
    required int page,
    required int limit,
  }) =>
      get(_getLocationListCacheKey(page, limit));

  Future<void> setLocationList({
    required int page,
    required int limit,
    required String data,
  }) =>
      put(_getLocationListCacheKey(page, limit), data);
}
