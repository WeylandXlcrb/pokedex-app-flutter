import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/models/api_resource.dart';
import 'package:pokedex_app/models/generation_game_index.dart';
import 'package:pokedex_app/models/item/item_holder_pokemon.dart';
import 'package:pokedex_app/models/item/item_sprites.dart';
import 'package:pokedex_app/models/machine_version_detail.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/verbose_effect.dart';
import 'package:pokedex_app/models/version_group_flavor_text.dart';

part 'item.g.dart';

abstract class Item implements Built<Item, ItemBuilder> {
  static Serializer<Item> get serializer => _$itemSerializer;

  /// The identifier for this resource.
  int get id;

  /// The name for this resource.
  String get name;

  /// The price of this item in stores.
  int get cost;

  /// The power of the move Fling when used with this item.
  @BuiltValueField(wireName: 'fling_power')
  int? get flingPower;

  /// The effect of the move Fling when used with this item.
  @BuiltValueField(wireName: 'fling_effect')
  NamedAPIResource get flingEffect;

  /// A list of attributes this item has.
  BuiltList<NamedAPIResource> get attributes;

  /// The category of items this item falls into.
  NamedAPIResource get category;

  @BuiltValueField(wireName: 'effect_entries')
  BuiltList<VerboseEffect> get effectEntries;

  /// The flavor text of this ability listed in different languages.
  @BuiltValueField(wireName: 'flavor_text_entries')
  BuiltList<VersionGroupFlavorText> get flavorTextEntries;

  /// A list of game indices relevent to this item by generation.
  @BuiltValueField(wireName: 'game_indices')
  BuiltList<GenerationGameIndex> get gameIndices;

  /// The name of this item listed in different languages.
  BuiltList<Name> get names;

  /// A set of sprites used to depict this item in the game.
  ItemSprites get sprites;

  /// A list of Pokémon that might be found in the wild holding this item.
  @BuiltValueField(wireName: 'held_by_pokemon')
  BuiltList<ItemHolderPokemon> get heldByPokemons;

  /// An evolution chain this item requires to produce a bay during mating.
  @BuiltValueField(wireName: 'baby_trigger_for')
  APIResource? get babyTriggerFor;

  /// A list of the machines related to this item.
  BuiltList<MachineVersionDetail> get machines;

  VersionGroupFlavorText get flavorTextDefault => flavorTextEntries.firstWhere(
        (p0) => p0.language.name == kLanguageCodeDefault,
        orElse: () => flavorTextEntries.first,
      );

  VerboseEffect get effectDefault => effectEntries.firstWhere(
        (p0) => p0.language.name == kLanguageCodeDefault,
        orElse: () => effectEntries.first,
      );

  Item._();

  factory Item([void Function(ItemBuilder) updates]) = _$Item;
}
