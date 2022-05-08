import 'package:hive/hive.dart';

abstract class TimeBasedCache {
  late LazyBox box;

  String get boxName;

  Duration get cacheDuration;

  Future<void> init() async {
    box = await Hive.openLazyBox(boxName);
  }

  String cachedAtKey(String key) => '${key}_cachedAt';

  Future<bool> isExpired(String cacheKey) async {
    final cachedAtTimeKey = cachedAtKey(cacheKey);
    final dateTimeStr = await box.get(cachedAtTimeKey);

    if (dateTimeStr == null) {
      return true;
    }

    return DateTime.parse(dateTimeStr)
        .add(cacheDuration)
        .isBefore(DateTime.now());
  }

  Future<void> put(String key, dynamic data) async {
    await box.putAll({
      key: data,
      cachedAtKey(key): DateTime.now().toIso8601String(),
    });
  }

  Future<CachedData<T>?> get<T>(String key) async {
    if (!box.containsKey(key)) {
      return null;
    }

    return CachedData<T>(
      data: await box.get(key),
      isExpired: await isExpired(key),
    );
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
