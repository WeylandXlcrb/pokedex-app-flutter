import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'effect.g.dart';

abstract class Effect implements Built<Effect, EffectBuilder> {
  static Serializer<Effect> get serializer => _$effectSerializer;

  /// The localized effect text for an API resource in a specific language.
  String get effect;

  /// The language this effect is in.
  NamedAPIResource get language;

  Effect._();

  factory Effect([void Function(EffectBuilder) updates]) = _$Effect;
}
