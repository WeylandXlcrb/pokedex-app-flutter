import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'encounter_version_details.g.dart';

abstract class EncounterVersionDetails
    implements Built<EncounterVersionDetails, EncounterVersionDetailsBuilder> {
  static Serializer<EncounterVersionDetails> get serializer =>
      _$encounterVersionDetailsSerializer;

  /// The chance of an encounter to occur.
  int get rate;

  /// The version of the game in which the encounter can occur with the given chance.
  NamedAPIResource get version;

  EncounterVersionDetails._();

  factory EncounterVersionDetails(
          [void Function(EncounterVersionDetailsBuilder) updates]) =
      _$EncounterVersionDetails;
}
