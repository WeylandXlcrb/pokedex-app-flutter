import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'verbose_effect.g.dart';

abstract class VerboseEffect
    implements Built<VerboseEffect, VerboseEffectBuilder> {
  static Serializer<VerboseEffect> get serializer => _$verboseEffectSerializer;

  /// The localized effect text for an API resource in a specific language.
  String get effect;

  /// The localized effect text in brief.
  @BuiltValueField(wireName: 'short_effect')
  String get shortEffect;

  /// The language this effect is in.
  NamedAPIResource get language;

  VerboseEffect._();

  factory VerboseEffect([void Function(VerboseEffectBuilder) updates]) =
      _$VerboseEffect;
}
