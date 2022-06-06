import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/move/move.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/repos/http_cached_repo.dart';
import 'package:pokedex_app/repos/moves_repo.dart';
import 'package:pokedex_app/requests/moves/move_list_request.dart';
import 'package:pokedex_app/requests/moves/move_request.dart';
import 'package:pokedex_app/services/moves_cache.dart';

class HttpCachedMoveRepo extends HttpCachedRepo implements MovesRepo {
  final _cache = MovesCache();

  @override
  Future<NamedAPIResourceList> getMoveList({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) async =>
      getCachedData(
        serializer: NamedAPIResourceList.serializer,
        createRequest: () => MoveListRequest(page: page, limit: limit),
        getCachedData: () => _cache.getMoveList(page: page, limit: limit),
        setCachedData: (data) =>
            _cache.setMoveList(page: page, limit: limit, data: data),
      );

  @override
  Future<Move> getMove(String name) async => getCachedData(
        serializer: Move.serializer,
        createRequest: () => MoveRequest(name: name),
        getCachedData: () => _cache.getMove(name),
        setCachedData: (data) => _cache.setMove(name: name, data: data),
      );
}
