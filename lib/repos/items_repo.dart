import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';

abstract class ItemsRepo {
  Future<NamedAPIResourceList> getItems({int page, int limit});

  Future<Item> getItem(String name);
}
