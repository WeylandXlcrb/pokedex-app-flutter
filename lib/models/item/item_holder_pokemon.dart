import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item_version.dart';

part 'item_holder_pokemon.g.dart';

abstract class ItemHolderPokemon
    implements Built<ItemHolderPokemon, ItemHolderPokemonBuilder> {
  static Serializer<ItemHolderPokemon> get serializer =>
      _$itemHolderPokemonSerializer;

  /// The Pokémon that holds this item.
  NamedAPIResource get pokemon;

  /// The details for the version that this item is held in by the Pokémon.
  @BuiltValueField(wireName: 'version_details')
  BuiltList<PokemonHeldItemVersion> get versionDetails;

  ItemHolderPokemon._();

  factory ItemHolderPokemon([void Function(ItemHolderPokemonBuilder) updates]) =
      _$ItemHolderPokemon;
}
