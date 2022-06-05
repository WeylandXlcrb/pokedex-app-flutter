import 'package:pokedex_app/models/named_api_resource_list.dart';

abstract class LocationsRepo {
  Future<NamedAPIResourceList> getLocationList({int page, int limit});
}
