import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'pokemon_held_item_version.g.dart';

abstract class PokemonHeldItemVersion
    implements Built<PokemonHeldItemVersion, PokemonHeldItemVersionBuilder> {
  static Serializer<PokemonHeldItemVersion> get serializer =>
      _$pokemonHeldItemVersionSerializer;

  /// The version in which the item is held.
  NamedAPIResource get version;

  /// How often the item is held.
  int get rarity;

  PokemonHeldItemVersion._();

  factory PokemonHeldItemVersion(
          [void Function(PokemonHeldItemVersionBuilder) updates]) =
      _$PokemonHeldItemVersion;
}
