import 'package:http/http.dart' as http;

import 'package:pokedex_app/requests/api_request.dart';

class LocationAreaRequest extends ApiRequest {
  final String name;

  LocationAreaRequest({required this.name});

  @override
  Future<http.Response> request() => http.get(uri);

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/location-area/$name/');
}
