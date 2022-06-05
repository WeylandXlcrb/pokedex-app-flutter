import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/requests/api_request.dart';

class LocationsRequest extends ApiRequest {
  final int page;
  final int limit;

  LocationsRequest({
    this.page = 1,
    this.limit = kPerPageDefaultLimit,
  });

  int get _offset => (page - 1) * limit;

  @override
  Future<http.Response> request() => get(uri);

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/location/').replace(
        queryParameters: {
          'limit': '$limit',
          'offset': '$_offset',
        },
      );
}
