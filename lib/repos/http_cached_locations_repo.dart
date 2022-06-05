import 'dart:convert';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/serializers.dart';
import 'package:pokedex_app/repos/locations_repo.dart';
import 'package:pokedex_app/requests/locations/locations_request.dart';
import 'package:pokedex_app/services/locations_cache.dart';

class HttpCachedLocationsRepo implements LocationsRepo {
  final _cache = LocationsCache();

  @override
  Future<NamedAPIResourceList> getLocationList({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) async {
    final cachedData = await _cache.getLocationList(page: page, limit: limit);
    final String body;

    if (cachedData?.isExpired != false) {
      body = await LocationsRequest(page: page, limit: limit).send();
      _cache.setLocationList(page: page, limit: limit, data: body);
    } else {
      body = cachedData!.data;
    }

    return serializers.deserializeWith(
      NamedAPIResourceList.serializer,
      json.decode(body),
    )!;
  }
}
