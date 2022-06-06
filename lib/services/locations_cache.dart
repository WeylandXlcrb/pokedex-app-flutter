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

  String _getLocationCacheKey(String name) => 'Location-$name}';

  String _getRegionCacheKey(String name) => 'Region-$name';

  String _getLocationAreaCacheKey(String name) => 'Location-Area-$name';

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

  Future<CachedData<String>?> getLocation(String name) =>
      get(_getLocationCacheKey(name));

  Future<void> setLocation({required String name, required String data}) =>
      put(_getLocationCacheKey(name), data);

  Future<CachedData<String>?> getRegion(String name) =>
      get(_getRegionCacheKey(name));

  Future<void> setRegion({required String name, required String data}) =>
      put(_getRegionCacheKey(name), data);

  Future<CachedData<String>?> getLocationArea(String name) =>
      get(_getLocationAreaCacheKey(name));

  Future<void> setLocationArea({required String name, required String data}) =>
      put(_getLocationAreaCacheKey(name), data);
}
