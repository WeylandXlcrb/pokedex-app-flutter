import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'encounter.g.dart';

abstract class Encounter implements Built<Encounter, EncounterBuilder> {
  static Serializer<Encounter> get serializer => _$encounterSerializer;

  /// The lowest level the Pokémon could be encountered at.
  @BuiltValueField(wireName: 'min_level')
  int get minLevel;

  /// The highest level the Pokémon could be encountered at.
  @BuiltValueField(wireName: 'max_level')
  int get maxLevel;

  /// A list of condition values that must be in effect for this encounter to occur.
  @BuiltValueField(wireName: 'condition_values')
  BuiltList<NamedAPIResource> get conditionValues;

  /// Percent chance that this encounter will occur.
  int get chance;

  /// The method by which this encounter happens.
  NamedAPIResource get method;

  Encounter._();

  factory Encounter([void Function(EncounterBuilder) updates]) = _$Encounter;
}
