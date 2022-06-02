import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import 'package:pokedex_app/models/effect.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'ability_effect_change.g.dart';

abstract class AbilityEffectChange
    implements Built<AbilityEffectChange, AbilityEffectChangeBuilder> {
  static Serializer<AbilityEffectChange> get serializer =>
      _$abilityEffectChangeSerializer;

  /// The previous effect of this ability listed in different languages.
  @BuiltValueField(wireName: 'effect_entries')
  BuiltList<Effect> get effectEntries;

  /// The version group in which the previous effect of this ability originated.
  @BuiltValueField(wireName: 'version_group')
  NamedAPIResource get versionGroup;

  AbilityEffectChange._();

  factory AbilityEffectChange(
          [void Function(AbilityEffectChangeBuilder) updates]) =
      _$AbilityEffectChange;
}
