import 'package:http/http.dart' as http;
import 'package:pokedex_app/requests/api_request.dart';

class PokemonSpeciesRequest extends ApiRequest {
  final String pokemonName;

  PokemonSpeciesRequest({required this.pokemonName});

  @override
  Uri get uri =>
      Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$pokemonName/');

  @override
  Future<http.Response> request() => http.get(uri);
}
