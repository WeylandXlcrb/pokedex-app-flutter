import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import 'package:pokedex_app/models/effect.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'ability_change_effect.g.dart';

abstract class AbilityChangeEffect
    implements Built<AbilityChangeEffect, AbilityChangeEffectBuilder> {
  static Serializer<AbilityChangeEffect> get serializer =>
      _$abilityChangeEffectSerializer;

  /// The previous effect of this ability listed in different languages.
  @BuiltValueField(wireName: 'effect_entries')
  BuiltList<Effect> get effectEntries;

  /// The version group in which the previous effect of this ability originated.
  @BuiltValueField(wireName: 'version_group')
  NamedAPIResource get versionGroup;

  AbilityChangeEffect._();

  factory AbilityChangeEffect(
          [void Function(AbilityChangeEffectBuilder) updates]) =
      _$AbilityChangeEffect;
}
