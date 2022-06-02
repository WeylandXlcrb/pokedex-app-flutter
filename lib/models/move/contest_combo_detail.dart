import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'contest_combo_detail.g.dart';

abstract class ContestComboDetail
    implements Built<ContestComboDetail, ContestComboDetailBuilder> {
  static Serializer<ContestComboDetail> get serializer =>
      _$contestComboDetailSerializer;

  /// A list of moves to use before this move.
  @BuiltValueField(wireName: 'use_before')
  BuiltList<NamedAPIResource>? get useBefore;

  /// A list of moves to use after this move.
  @BuiltValueField(wireName: 'use_after')
  BuiltList<NamedAPIResource>? get useAfter;

  ContestComboDetail._();

  factory ContestComboDetail(
          [void Function(ContestComboDetailBuilder) updates]) =
      _$ContestComboDetail;
}
