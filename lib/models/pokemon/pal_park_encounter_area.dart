import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'pal_park_encounter_area.g.dart';

abstract class PalParkEncounterArea
    implements Built<PalParkEncounterArea, PalParkEncounterAreaBuilder> {
  static Serializer<PalParkEncounterArea> get serializer =>
      _$palParkEncounterAreaSerializer;

  /// The base score given to the player when the referenced Pokémon is
  /// caught during a pal park run.
  @BuiltValueField(wireName: 'base_score')
  int get baseScore;

  /// The base rate for encountering the referenced Pokémon in this pal park area.
  int get rate;

  /// The pal park area where this encounter happens.
  NamedAPIResource get area;

  PalParkEncounterArea._();

  factory PalParkEncounterArea(
          [void Function(PalParkEncounterAreaBuilder) updates]) =
      _$PalParkEncounterArea;
}
