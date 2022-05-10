import 'package:http/http.dart' as http;
import 'package:pokedex_app/requests/api_request.dart';

class PokemonRequest extends ApiRequest {
  final String pokemonName;

  PokemonRequest({required this.pokemonName});

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName/');

  @override
  Future<http.Response> request() => http.get(uri);
}
