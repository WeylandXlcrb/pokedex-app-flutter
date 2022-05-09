import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move_version.dart';

part 'pokemon_move.g.dart';

abstract class PokemonMove implements Built<PokemonMove, PokemonMoveBuilder> {
  static Serializer<PokemonMove> get serializer => _$pokemonMoveSerializer;

  /// The move the Pokémon can learn.
  NamedAPIResource get move;

  /// The details of the version in which the Pokémon can learn the move.
  @BuiltValueField(wireName: 'version_group_details')
  BuiltList<PokemonMoveVersion> get versionGroupDetails;

  PokemonMove._();

  factory PokemonMove([void Function(PokemonMoveBuilder) updates]) =
      _$PokemonMove;
}
