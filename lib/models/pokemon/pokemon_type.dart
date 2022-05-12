import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/type_parser.dart';

part 'pokemon_type.g.dart';

abstract class PokemonType
    with TypeParser
    implements Built<PokemonType, PokemonTypeBuilder> {
  static Serializer<PokemonType> get serializer => _$pokemonTypeSerializer;

  /// The order the Pokémon's types are listed in.
  int get slot;

  /// The type the referenced Pokémon has.
  NamedAPIResource get type;

  @override
  String get name => type.name;

  PokemonType._();

  factory PokemonType([void Function(PokemonTypeBuilder) updates]) =
      _$PokemonType;
}
