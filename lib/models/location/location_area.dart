import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/location/encounter_method_rate.dart';
import 'package:pokedex_app/models/location/pokemon_encounter.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'location_area.g.dart';

abstract class LocationArea
    implements Built<LocationArea, LocationAreaBuilder> {
  static Serializer<LocationArea> get serializer => _$locationAreaSerializer;

  /// The identifier for this resource.
  int get id;

  /// The name for this resource.
  String get name;

  /// The internal id of an API resource within game data.
  @BuiltValueField(wireName: 'game_index')
  int get gameIndex;

  /// A list of methods in which Pokémon may be encountered in this area and
  /// how likely the method will occur depending on the version of the game.
  @BuiltValueField(wireName: 'encounter_method_rates')
  BuiltList<EncounterMethodRate> get encounterMethodRates;

  /// The region this location area can be found in.
  NamedAPIResource get location;

  /// The name of this resource listed in different languages.
  BuiltList<Name> get names;

  /// A list of Pokémon that can be encountered in this area along with version
  /// specific details about the encounter.
  @BuiltValueField(wireName: 'pokemon_encounters')
  BuiltList<PokemonEncounter> get pokemonEncounters;

  LocationArea._();

  factory LocationArea([void Function(LocationAreaBuilder) updates]) =
      _$LocationArea;
}
