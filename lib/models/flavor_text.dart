import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'flavor_text.g.dart';

abstract class FlavorText implements Built<FlavorText, FlavorTextBuilder> {
  static Serializer<FlavorText> get serializer => _$flavorTextSerializer;

  /// The localized flavor text for an API resource in a specific language.
  @BuiltValueField(wireName: 'flavor_text')
  String get text;

  /// The language this name is in.
  NamedAPIResource get language;

  /// The game version this flavor text is extracted from.
  NamedAPIResource get version;

  FlavorText._();

  factory FlavorText([void Function(FlavorTextBuilder) updates]) = _$FlavorText;
}
