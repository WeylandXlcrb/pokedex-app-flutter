import 'dart:convert';

import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/serializers.dart';
import 'package:pokedex_app/requests/api_request.dart';
import 'package:pokedex_app/services/cache.dart';

abstract class HttpCachedRepo {
  /// Fetch cached data, serialize using [serializer] it to model
  /// with `built_value` and return model. Provide [createRequest] to lazily
  /// create http request if cached data is expired or absent.
  /// provide [getCachedData] to fetch cached string data from cache source
  /// provide [setCachedData] to save json string into cache
  Future<T> getCachedData<T>({
    required Serializer<T> serializer,
    required ApiRequest Function() createRequest,
    required Future<CachedData<String>?> Function() getCachedData,
    required void Function(String data) setCachedData,
  }) async {
    final cachedData = await getCachedData();
    final String body;

    if (cachedData?.isExpired != false) {
      body = await createRequest().send();
      setCachedData(body);
    } else {
      body = cachedData!.data;
    }

    return serializers.deserializeWith(serializer, json.decode(body))!;
  }
}
