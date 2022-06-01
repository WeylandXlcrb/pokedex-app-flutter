import 'package:pokedex_app/models/named_api_resource_list.dart';

abstract class MovesRepo {
  Future<NamedAPIResourceList> getMoveList({int page, int limit});
}