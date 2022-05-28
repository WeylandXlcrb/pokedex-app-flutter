import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'type_pokemon.g.dart';

abstract class TypePokemon implements Built<TypePokemon, TypePokemonBuilder> {
  static Serializer<TypePokemon> get serializer => _$typePokemonSerializer;

  /// The order the Pokémon's types are listed in.
  int get slot;

  /// The Pokémon that has the referenced type.
  NamedAPIResource get pokemon;

  TypePokemon._();

  factory TypePokemon([void Function(TypePokemonBuilder) updates]) =
      _$TypePokemon;
}
