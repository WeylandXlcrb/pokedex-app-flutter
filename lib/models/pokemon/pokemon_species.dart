import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/constants.dart';

import 'package:pokedex_app/models/api_resource.dart';
import 'package:pokedex_app/models/description.dart';
import 'package:pokedex_app/models/flavor_text.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/genus.dart';
import 'package:pokedex_app/models/pokemon/pal_park_encounter_area.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species_dex_entry.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species_variety.dart';

part 'pokemon_species.g.dart';

abstract class PokemonSpecies
    implements Built<PokemonSpecies, PokemonSpeciesBuilder> {
  static Serializer<PokemonSpecies> get serializer =>
      _$pokemonSpeciesSerializer;

  /// The identifier for this species.
  int get id;

  /// The name for this resource.
  String get name;

  /// The order in which species should be sorted. Based on National Dex order,
  /// except families are grouped together and sorted by stage.
  int get order;

  /// The chance of this Pokémon being female, in eighths; or -1 for genderless.
  @BuiltValueField(wireName: 'gender_rate')
  int get genderRate;

  /// The base capture rate; up to 255. The higher the number,
  /// the easier the catch.
  @BuiltValueField(wireName: 'capture_rate')
  int get captureRate;

  /// The happiness when caught by a normal Pokéball; up to 255. The higher
  /// the number, the happier the Pokémon.
  @BuiltValueField(wireName: 'base_happiness')
  int get baseHappiness;

  /// Whether or not this is a baby Pokémon.
  @BuiltValueField(wireName: 'is_baby')
  bool get isBaby;

  /// Whether or not this is a legendary Pokémon.
  @BuiltValueField(wireName: 'is_legendary')
  bool get isLegendary;

  /// Whether or not this is a mythical Pokémon.
  @BuiltValueField(wireName: 'is_mythical')
  bool get isMythical;

  /// Initial hatch counter: one must walk 255 × (hatch_counter + 1) steps
  /// before this Pokémon's egg hatches, unless utilizing bonuses
  /// like Flame Body's.
  @BuiltValueField(wireName: 'hatch_counter')
  int get hatchCounter;

  /// Whether or not this Pokémon has visual gender differences.
  @BuiltValueField(wireName: 'has_gender_differences')
  bool get hasGenderDifferences;

  /// Whether or not this Pokémon has multiple forms and can switch between them.
  @BuiltValueField(wireName: 'forms_switchable')
  bool get formsSwitchable;

  /// The rate at which this Pokémon species gains levels.
  @BuiltValueField(wireName: 'growth_rate')
  NamedAPIResource get growthRate;

  /// A list of Pokedexes and the indexes reserved within them for
  /// this Pokémon species.
  @BuiltValueField(wireName: 'pokedex_numbers')
  BuiltList<PokemonSpeciesDexEntry> get pokedexNumbers;

  /// A list of egg groups this Pokémon species is a member of.
  @BuiltValueField(wireName: 'egg_groups')
  BuiltList<NamedAPIResource> get eggGroups;

  /// The color of this Pokémon for Pokédex search.
  NamedAPIResource get color;

  /// The shape of this Pokémon for Pokédex search.
  NamedAPIResource get shape;

  /// The Pokémon species that evolves into this Pokemon_species.
  @BuiltValueField(wireName: 'evolves_from_species')
  NamedAPIResource? get evolvesFromSpecies;

  /// The evolution chain this Pokémon species is a member of.
  @BuiltValueField(wireName: 'evolution_chain')
  APIResource get evolutionChain;

  /// The habitat this Pokémon species can be encountered in.
  NamedAPIResource? get habitat;

  /// The generation this Pokémon species was introduced in.
  NamedAPIResource get generation;

  /// The name of this resource listed in different languages.
  BuiltList<Name> get names;

  /// A list of encounters that can be had with this Pokémon species in pal park.
  @BuiltValueField(wireName: 'pal_park_encounters')
  BuiltList<PalParkEncounterArea> get palParkEncounters;

  /// A list of flavor text entries for this Pokémon species.
  @BuiltValueField(wireName: 'flavor_text_entries')
  BuiltList<FlavorText> get flavorTextEntries;

  /// Descriptions of different forms Pokémon take on within the Pokémon species.
  @BuiltValueField(wireName: 'form_descriptions')
  BuiltList<Description> get formDescriptions;

  /// The genus of this Pokémon species listed in multiple languages.
  BuiltList<Genus> get genera;

  /// A list of the Pokémon that exist within this Pokémon species.
  BuiltList<PokemonSpeciesVariety> get varieties;

  /// Whether pokemon genderless or not
  bool get isGenderless => genderRate == -1;

  /// Gender Rate of females in percents
  double get genderRateFemale => genderRate / 8 * 100;

  /// Gender Rate of males in percents
  double get genderRateMale => 100 - genderRateFemale;

  /// Base capture rate in percents. The higher the number, the easier the catch.
  double get captureRatePercent => captureRate / 255 * 100;

  /// Default flavor text entry (first english or first overall)
  /// for this Pokémon species.
  FlavorText get flavorTextDefault => flavorTextEntries.firstWhere(
        (f) => f.language.name == kLanguageCodeDefault,
        orElse: () => flavorTextEntries.first,
      );

  /// Default genus (first english or first overall) of this Pokémon species.
  Genus get genusDefault => genera.firstWhere(
        (g) => g.language.name == kLanguageCodeDefault,
        orElse: () => genera.first,
      );

  /// Get evolution chain id
  int get evolutionChainId {
    // MIGHT BE VERY ERROR PRONE
    final segments = Uri.parse(evolutionChain.url).pathSegments;
    return int.parse(segments[segments.length - 2]);
  }

  PokemonSpecies._();

  factory PokemonSpecies([void Function(PokemonSpeciesBuilder) updates]) =
      _$PokemonSpecies;
}
