import 'dart:convert';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/serializers.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/requests/pokemons/pokemon_list_request.dart';

class HttpCachedPokemonsRepo implements PokemonsRepo {
  @override
  Future<NamedAPIResourceList> getPokemonList({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) async {
    // TODO: Add CACHING

    final body = await PokemonListRequest(page: page, limit: limit).send();

    return serializers.deserializeWith(
      NamedAPIResourceList.serializer,
      json.decode(body),
    )!;
  }
}
