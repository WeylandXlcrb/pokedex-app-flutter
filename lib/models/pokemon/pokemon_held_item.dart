import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item_version.dart';

part 'pokemon_held_item.g.dart';

abstract class PokemonHeldItem
    implements Built<PokemonHeldItem, PokemonHeldItemBuilder> {
  static Serializer<PokemonHeldItem> get serializer =>
      _$pokemonHeldItemSerializer;

  /// The item the referenced Pokémon holds.
  NamedAPIResource get item;

  /// The details of the different versions in which the item is held.
  @BuiltValueField(wireName: 'version_details')
  BuiltList<PokemonHeldItemVersion> get versionDetails;

  PokemonHeldItem._();

  factory PokemonHeldItem([void Function(PokemonHeldItemBuilder) updates]) =
      _$PokemonHeldItem;
}
