import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/repos/http_cached_repo.dart';
import 'package:pokedex_app/repos/items_repo.dart';
import 'package:pokedex_app/requests/items/item_list_request.dart';
import 'package:pokedex_app/requests/items/item_request.dart';
import 'package:pokedex_app/services/items_cache.dart';

class HttpCachedItemsRepo extends HttpCachedRepo implements ItemsRepo {
  final _cache = ItemsCache();

  @override
  Future<NamedAPIResourceList> getItems({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) =>
      getCachedData(
        serializer: NamedAPIResourceList.serializer,
        createRequest: () => ItemListRequest(page: page, limit: limit),
        getCachedData: () => _cache.getItemList(page: page, limit: limit),
        setCachedData: (data) =>
            _cache.setItemList(page: page, limit: limit, data: data),
      );

  @override
  Future<Item> getItem(String name) => getCachedData(
        serializer: Item.serializer,
        createRequest: () => ItemRequest(name: name),
        getCachedData: () => _cache.getItem(name),
        setCachedData: (data) => _cache.setItem(name: name, data: data),
      );
}
