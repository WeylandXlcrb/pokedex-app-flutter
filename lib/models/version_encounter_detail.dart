import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/encounter.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'version_encounter_detail.g.dart';

abstract class VersionEncounterDetail
    implements Built<VersionEncounterDetail, VersionEncounterDetailBuilder> {
  static Serializer<VersionEncounterDetail> get serializer =>
      _$versionEncounterDetailSerializer;

  /// The game version this encounter happens in.
  NamedAPIResource get version;

  /// The total percentage of all encounter potential.
  @BuiltValueField(wireName: 'max_chance')
  int get maxChance;

  /// A list of encounters and their specifics.
  @BuiltValueField(wireName: 'encounter_details')
  BuiltList<Encounter> get encounterDetails;

  VersionEncounterDetail._();

  factory VersionEncounterDetail(
      [void Function(VersionEncounterDetailBuilder) updates]) =
  _$VersionEncounterDetail;
}
