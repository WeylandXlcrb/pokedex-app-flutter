import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';

part 'pokemon_type_past.g.dart';

abstract class PokemonTypePast
    implements Built<PokemonTypePast, PokemonTypePastBuilder> {
  static Serializer<PokemonTypePast> get serializer =>
      _$pokemonTypePastSerializer;

  /// The last generation in which the referenced pokémon had the listed types.
  NamedAPIResource get generation;

  /// The types the referenced pokémon had up to and including the listed generation.
  BuiltList<PokemonType> get types;

  PokemonTypePast._();

  factory PokemonTypePast([void Function(PokemonTypePastBuilder) updates]) =
      _$PokemonTypePast;
}
