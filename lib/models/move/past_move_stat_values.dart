import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/verbose_effect.dart';

part 'past_move_stat_values.g.dart';

abstract class PastMoveStatValues
    implements Built<PastMoveStatValues, PastMoveStatValuesBuilder> {
  static Serializer<PastMoveStatValues> get serializer =>
      _$pastMoveStatValuesSerializer;

  /// The percent value of how likely this move is to be successful.
  int? get accuracy;

  /// The percent value of how likely it is this moves effect will take effect.
  @BuiltValueField(wireName: 'effect_chance')
  int? get effectChance;

  /// The base power of this move with a value of 0 if it does not have a base power.
  int? get power;

  /// Power points. The number of times this move can be used.
  int? get pp;

  /// The effect of this move listed in different languages.
  @BuiltValueField(wireName: 'effect_entries')
  BuiltList<VerboseEffect> get effectEntries;

  /// The elemental type of this move.
  NamedAPIResource get type;

  /// The version group in which these move stat values were in effect.
  @BuiltValueField(wireName: 'version_group')
  NamedAPIResource get versionGroup;

  PastMoveStatValues._();

  factory PastMoveStatValues(
          [void Function(PastMoveStatValuesBuilder) updates]) =
      _$PastMoveStatValues;
}
