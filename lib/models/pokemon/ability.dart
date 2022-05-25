import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:pokedex_app/constants.dart';

import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/ability_change_effect.dart';
import 'package:pokedex_app/models/pokemon/ability_flavor_text.dart';
import 'package:pokedex_app/models/pokemon/ability_pokemon.dart';
import 'package:pokedex_app/models/verbose_effect.dart';

part 'ability.g.dart';

abstract class Ability implements Built<Ability, AbilityBuilder> {
  static Serializer<Ability> get serializer => _$abilitySerializer;

  /// The identifier for this resource.
  int get id;

  /// The name for this resource.
  String get name;

  /// Whether or not this ability originated in the main series of the video games.
  @BuiltValueField(wireName: 'is_main_series')
  bool get isMainSeries;

  /// The generation this ability originated in.
  NamedAPIResource get generation;

  /// The name of this resource listed in different languages.
  BuiltList<Name> get names;

  /// The effect of this ability listed in different languages.
  @BuiltValueField(wireName: 'effect_entries')
  BuiltList<VerboseEffect> get effectEntries;

  /// The list of previous effects this ability has had across version groups.
  @BuiltValueField(wireName: 'effect_changes')
  BuiltList<AbilityChangeEffect> get effectChanges;

  /// The flavor text of this ability listed in different languages.
  @BuiltValueField(wireName: 'flavor_text_entries')
  BuiltList<AbilityFlavorText> get flavorTextEntries;

  /// A list of Pokémon that could potentially have this ability.
  @BuiltValueField(wireName: 'pokemon')
  BuiltList<AbilityPokemon> get pokemons;

  /// Default flavor text for language (english) or first if language absent;
  AbilityFlavorText get flavorTextDefault => flavorTextEntries.firstWhere(
        (f) => f.language.name == kLanguageCodeDefault,
        orElse: () => flavorTextEntries.first,
      );

  VerboseEffect get effectDefault => effectEntries.firstWhere(
        (e) => e.language.name == kLanguageCodeDefault,
        orElse: () => effectEntries.first,
      );

  Ability._();

  factory Ability([void Function(AbilityBuilder) updates]) = _$Ability;
}
