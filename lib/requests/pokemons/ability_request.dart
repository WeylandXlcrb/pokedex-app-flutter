import 'package:http/http.dart' as http;
import 'package:pokedex_app/requests/api_request.dart';

class AbilityRequest extends ApiRequest {
  final String name;

  AbilityRequest({required this.name});

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/ability/$name/');

  @override
  Future<http.Response> request() => http.get(uri);
}
