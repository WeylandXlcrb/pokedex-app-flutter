import 'package:hive/hive.dart';

const _cachedAtSuffix = '_cachedAt';

abstract class TimeBasedCache {
  late LazyBox box;

  String get boxName;

  Duration get cacheDuration;

  Future<void> init() async {
    box = await Hive.openLazyBox(boxName);
    await _clearExpiredData();
  }

  Future<bool> isExpired(String cacheKey) async {
    final dateTimeStr = await box.get(_cachedAtKey(cacheKey));

    return dateTimeStr == null
        ? true
        : DateTime.parse(dateTimeStr)
            .add(cacheDuration)
            .isBefore(DateTime.now());
  }

  Future<void> put(String key, dynamic data) => box.putAll({
        key: data,
        _cachedAtKey(key): DateTime.now().toIso8601String(),
      });

  Future<CachedData<T>?> get<T>(String key) async => box.containsKey(key)
      ? CachedData<T>(
          data: await box.get(key),
          isExpired: await isExpired(key),
        )
      : null;

  String _cachedAtKey(String key) => '$key$_cachedAtSuffix';

  Future<void> _clearExpiredData() async {
    final keys = box.keys.where((k) => !k.toString().contains(_cachedAtSuffix));

    for (final key in keys) {
      if (!(await isExpired(key))) continue;

      await box.deleteAll([key, _cachedAtKey(key)]);
    }
  }
}

class CachedData<T> {
  final T data;
  final bool isExpired;

  const CachedData({
    required this.data,
    required this.isExpired,
  });
}
