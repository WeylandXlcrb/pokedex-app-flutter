import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'pokemon_type.g.dart';

abstract class PokemonType implements Built<PokemonType, PokemonTypeBuilder> {
  static Serializer<PokemonType> get serializer => _$pokemonTypeSerializer;

  /// The order the Pokémon's types are listed in.
  int get slot;

  /// The type the referenced Pokémon has.
  NamedAPIResource get type;

  PokemonType._();

  factory PokemonType([void Function(PokemonTypeBuilder) updates]) =
      _$PokemonType;
}
