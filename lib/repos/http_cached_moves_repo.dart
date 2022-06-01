import 'dart:convert';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/serializers.dart';
import 'package:pokedex_app/repos/moves_repo.dart';
import 'package:pokedex_app/requests/moves/move_list_request.dart';
import 'package:pokedex_app/services/moves_cache.dart';

class HttpCachedMoveRepo implements MovesRepo {
  final _cache = MovesCache();

  @override
  Future<NamedAPIResourceList> getMoveList({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) async {
    final cachedData = await _cache.getMoveList(page: page, limit: limit);
    final String body;

    if (cachedData?.isExpired != false) {
      body = await MoveListRequest(page: page, limit: limit).send();
      _cache.setMoveList(page: page, limit: limit, data: body);
    } else {
      body = cachedData!.data;
    }

    return serializers.deserializeWith(
      NamedAPIResourceList.serializer,
      json.decode(body),
    )!;
  }
}
