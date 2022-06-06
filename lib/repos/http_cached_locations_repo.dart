import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/location/location.dart';
import 'package:pokedex_app/models/location/location_area.dart';
import 'package:pokedex_app/models/location/region.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/repos/http_cached_repo.dart';
import 'package:pokedex_app/repos/locations_repo.dart';
import 'package:pokedex_app/requests/locations/location_area_request.dart';
import 'package:pokedex_app/requests/locations/location_list_request.dart';
import 'package:pokedex_app/requests/locations/location_request.dart';
import 'package:pokedex_app/requests/locations/region_request.dart';
import 'package:pokedex_app/services/locations_cache.dart';

class HttpCachedLocationsRepo extends HttpCachedRepo implements LocationsRepo {
  final _cache = LocationsCache();

  @override
  Future<NamedAPIResourceList> getLocationList({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) async =>
      getCachedData(
        serializer: NamedAPIResourceList.serializer,
        createRequest: () => LocationListRequest(page: page, limit: limit),
        getCachedData: () => _cache.getLocationList(page: page, limit: limit),
        setCachedData: (data) =>
            _cache.setLocationList(page: page, limit: limit, data: data),
      );

  @override
  Future<Location> getLocation(String name) async => getCachedData(
        serializer: Location.serializer,
        createRequest: () => LocationRequest(name: name),
        getCachedData: () => _cache.getLocation(name),
        setCachedData: (data) => _cache.setLocation(name: name, data: data),
      );

  @override
  Future<LocationArea> getLocationArea(String name) => getCachedData(
        serializer: LocationArea.serializer,
        createRequest: () => LocationAreaRequest(name: name),
        getCachedData: () => _cache.getLocationArea(name),
        setCachedData: (data) => _cache.setLocationArea(name: name, data: data),
      );

  @override
  Future<Region> getRegion(String name) => getCachedData(
        serializer: Region.serializer,
        createRequest: () => RegionRequest(name: name),
        getCachedData: () => _cache.getRegion(name),
        setCachedData: (data) => _cache.setRegion(name: name, data: data),
      );
}
