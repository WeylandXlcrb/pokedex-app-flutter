import 'package:pokedex_app/models/location/location.dart';
import 'package:pokedex_app/models/location/location_area.dart';
import 'package:pokedex_app/models/location/region.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';

abstract class LocationsRepo {
  Future<NamedAPIResourceList> getLocationList({int page, int limit});

  Future<Location> getLocation(String name);

  Future<Region> getRegion(String name);

  Future<LocationArea> getLocationArea(String name);
}
