import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'ability_flavor_text.g.dart';

abstract class AbilityFlavorText
    implements Built<AbilityFlavorText, AbilityFlavorTextBuilder> {
  static Serializer<AbilityFlavorText> get serializer =>
      _$abilityFlavorTextSerializer;

  /// The localized name for an API resource in a specific language.
  @BuiltValueField(wireName: 'flavor_text')
  String get text;

  /// The language this text resource is in.
  NamedAPIResource get language;

  /// The version group that uses this flavor text.
  @BuiltValueField(wireName: 'version_group')
  NamedAPIResource get versionGroup;

  AbilityFlavorText._();

  factory AbilityFlavorText([void Function(AbilityFlavorTextBuilder) updates]) =
      _$AbilityFlavorText;
}
