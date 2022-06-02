import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'move_meta_data.g.dart';

abstract class MoveMetaData
    implements Built<MoveMetaData, MoveMetaDataBuilder> {
  static Serializer<MoveMetaData> get serializer => _$moveMetaDataSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(MoveMetaDataBuilder b) => b
    ..minHits = 1
    ..maxHits = 1
    ..minTurns = 1
    ..maxTurns = 1;

  /// The status ailment this move inflicts on its target.
  NamedAPIResource get ailment;

  /// The category of move this move falls under, e.g. damage or ailment.
  NamedAPIResource get category;

  /// The minimum number of times this move hits.
  @BuiltValueField(wireName: 'min_hits')
  int get minHits;

  /// The maximum number of times this move hits.
  @BuiltValueField(wireName: 'max_hits')
  int get maxHits;

  /// The minimum number of turns this move continues to take effect.
  @BuiltValueField(wireName: 'min_turns')
  int get minTurns;

  /// The maximum number of turns this move continues to take effect.
  @BuiltValueField(wireName: 'max_turns')
  int get maxTurns;

  /// HP drain (if positive) or Recoil damage (if negative), in percent of damage done.
  int get drain;

  /// The amount of hp gained by the attacking Pokemon, in percent of it's maximum HP.
  int get healing;

  /// Critical hit rate bonus.
  @BuiltValueField(wireName: 'crit_rate')
  int get critRate;

  /// The likelihood this attack will cause an ailment.
  @BuiltValueField(wireName: 'ailment_chance')
  int get ailmentChance;

  /// The likelihood this attack will cause the target Pokémon to flinch.
  @BuiltValueField(wireName: 'flinch_chance')
  int get flinchChance;

  /// The likelihood this attack will cause a stat change in the target Pokémon.
  @BuiltValueField(wireName: 'stat_chance')
  int get statChance;

  MoveMetaData._();

  factory MoveMetaData([void Function(MoveMetaDataBuilder) updates]) =
      _$MoveMetaData;
}
