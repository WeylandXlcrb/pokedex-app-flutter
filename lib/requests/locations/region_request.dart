import 'package:http/http.dart' as http;

import 'package:pokedex_app/requests/api_request.dart';

class RegionRequest extends ApiRequest {
  final String name;

  RegionRequest({required this.name});

  @override
  Future<http.Response> request() => http.get(uri);

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/region/$name/');
}
