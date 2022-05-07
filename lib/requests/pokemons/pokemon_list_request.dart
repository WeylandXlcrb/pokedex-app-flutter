import 'package:http/http.dart' as http;
import 'package:pokedex_app/requests/api_request.dart';

class PokemonListRequest extends ApiRequest {
  final int page;
  final int limit;

  PokemonListRequest({
    this.page = 1,
    this.limit = 20,
  });

  int get _offset => (page - 1) * limit;

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/pokemon/').replace(
        queryParameters: {
          'limit': '$limit',
          'offset': '$_offset',
        },
      );

  @override
  Future<http.Response> request() async => http.get(uri);
}
