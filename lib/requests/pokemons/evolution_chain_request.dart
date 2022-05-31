import 'package:http/http.dart' as http;
import 'package:pokedex_app/requests/api_request.dart';

class EvolutionChainRequest extends ApiRequest {
  final int id;

  EvolutionChainRequest({required this.id});

  @override
  Future<http.Response> request() => http.get(uri);

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/evolution-chain/$id/');
}
