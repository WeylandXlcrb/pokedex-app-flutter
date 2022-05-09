import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'pokemon_ability.g.dart';

abstract class PokemonAbility
    implements Built<PokemonAbility, PokemonAbilityBuilder> {
  static Serializer<PokemonAbility> get serializer =>
      _$pokemonAbilitySerializer;

  /// Whether or not this is a hidden ability.
  @BuiltValueField(wireName: 'is_hidden')
  bool get isHidden;

  /// The slot this ability occupies in this Pokémon species.
  int get slot;

  /// The ability the Pokémon may have.
  NamedAPIResource get ability;

  PokemonAbility._();

  factory PokemonAbility([void Function(PokemonAbilityBuilder) updates]) =
      _$PokemonAbility;
}
