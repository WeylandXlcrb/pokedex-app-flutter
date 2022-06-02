import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/move/contest_combo_detail.dart';

part 'contest_combo_sets.g.dart';

abstract class ContestComboSets
    implements Built<ContestComboSets, ContestComboSetsBuilder> {
  static Serializer<ContestComboSets> get serializer =>
      _$contestComboSetsSerializer;

  /// A detail of moves this move can be used before or after, granting
  /// additional appeal points in contests.
  ContestComboDetail get normal;

  /// A detail of moves this move can be used before or after, granting
  /// additional appeal points in super contests.
  @BuiltValueField(wireName: 'super')
  ContestComboDetail get superContest; // Can't use super as field name since it's reserved keyword

  ContestComboSets._();

  factory ContestComboSets([void Function(ContestComboSetsBuilder) updates]) =
      _$ContestComboSets;
}
