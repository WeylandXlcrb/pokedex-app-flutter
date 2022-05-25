import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'ability_pokemon.g.dart';

abstract class AbilityPokemon
    implements Built<AbilityPokemon, AbilityPokemonBuilder> {
  static Serializer<AbilityPokemon> get serializer =>
      _$abilityPokemonSerializer;

  /// Whether or not this a hidden ability for the referenced Pokémon.
  @BuiltValueField(wireName: 'is_hidden')
  bool get isHidden;

  /// Pokémon have 3 ability 'slots' which hold references to possible
  /// abilities they could have. This is the slot of this ability for
  /// the referenced pokemon.
  int get slot;

  /// The Pokémon this ability could belong to.
  NamedAPIResource get pokemon;

  AbilityPokemon._();

  factory AbilityPokemon([void Function(AbilityPokemonBuilder) updates]) =
      _$AbilityPokemon;
}
