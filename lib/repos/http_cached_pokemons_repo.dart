import 'dart:convert';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/serializers.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/requests/pokemons/pokemon_list_request.dart';
import 'package:pokedex_app/services/pokemons_cache.dart';

class HttpCachedPokemonsRepo implements PokemonsRepo {
  final _cache = PokemonsCache();

  @override
  Future<NamedAPIResourceList> getPokemonList({
    int page = 1,
    int limit = kPerPageDefaultLimit,
  }) async {
    final cachedData = await _cache.getPokemonList(page: page, limit: limit);
    final String body;

    if (cachedData?.isExpired != false) {
      body = await PokemonListRequest(page: page, limit: limit).send();
      _cache.setPokemonList(page: page, limit: limit, data: body);
    } else {
      body = cachedData!.data;
    }

    return serializers.deserializeWith(
      NamedAPIResourceList.serializer,
      json.decode(body),
    )!;
  }
}
