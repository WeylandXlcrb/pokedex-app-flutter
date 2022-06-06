import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/location/encounter_version_details.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'encounter_method_rate.g.dart';

abstract class EncounterMethodRate
    implements Built<EncounterMethodRate, EncounterMethodRateBuilder> {
  static Serializer<EncounterMethodRate> get serializer =>
      _$encounterMethodRateSerializer;

  /// The method in which Pokémon may be encountered in an area..
  @BuiltValueField(wireName: 'encounter_method')
  NamedAPIResource get encounterMethod;

  /// The chance of the encounter to occur on a version of the game.
  @BuiltValueField(wireName: 'version_details')
  BuiltList<EncounterVersionDetails> get versionDetails;

  EncounterMethodRate._();

  factory EncounterMethodRate(
          [void Function(EncounterMethodRateBuilder) updates]) =
      _$EncounterMethodRate;
}
