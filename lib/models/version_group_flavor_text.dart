import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'version_group_flavor_text.g.dart';

abstract class VersionGroupFlavorText
    implements Built<VersionGroupFlavorText, VersionGroupFlavorTextBuilder> {
  static Serializer<VersionGroupFlavorText> get serializer =>
      _$versionGroupFlavorTextSerializer;

  /// The localized name for an API resource in a specific language.
  @BuiltValueField(wireName: 'flavor_text')
  String get text;

  /// The language this text resource is in.
  NamedAPIResource get language;

  /// The version group that uses this flavor text.
  @BuiltValueField(wireName: 'version_group')
  NamedAPIResource get versionGroup;

  VersionGroupFlavorText._();

  factory VersionGroupFlavorText(
          [void Function(VersionGroupFlavorTextBuilder) updates]) =
      _$VersionGroupFlavorText;
}
