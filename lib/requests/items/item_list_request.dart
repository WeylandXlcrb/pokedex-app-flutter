import 'package:http/http.dart' as http;
import 'package:pokedex_app/constants.dart';

import 'package:pokedex_app/requests/api_request.dart';

class ItemListRequest extends ApiRequest {
  final int page;
  final int limit;

  ItemListRequest({
    this.page = 1,
    this.limit = kPerPageDefaultLimit,
  });

  int get _offset => (page - 1) * limit;

  @override
  Future<http.Response> request() => http.get(uri);

  @override
  Uri get uri => Uri.parse('https://pokeapi.co/api/v2/item/').replace(
        queryParameters: {
          'offset': '$_offset',
          'limit': '$limit',
        },
      );
}
