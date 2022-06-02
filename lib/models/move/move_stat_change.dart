import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'move_stat_change.g.dart';

abstract class MoveStatChange
    implements Built<MoveStatChange, MoveStatChangeBuilder> {
  static Serializer<MoveStatChange> get serializer =>
      _$moveStatChangeSerializer;

  /// The amount of change.
  int get change;

  /// The stat being affected.
  NamedAPIResource get stat;

  MoveStatChange._();

  factory MoveStatChange([void Function(MoveStatChangeBuilder) updates]) =
      _$MoveStatChange;
}
